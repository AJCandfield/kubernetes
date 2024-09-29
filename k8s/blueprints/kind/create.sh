#!/bin/bash
set -o errexit

declare KIND_CLUSTER_NAME="main"
declare KIND_REGISTRY_NAME="kind-registry"
declare KIND_REGISTRY_PORT='5005'
declare SCRIPT_DIR

SCRIPT_DIR=$(dirname "$(readlink -f $0)")

function create_container_registry() {
  # Create registry container unless it already exists

  if [ "$(docker inspect -f '{{.State.Running}}' "${KIND_REGISTRY_NAME}" 2>/dev/null || true)" != 'true' ]; then
    docker run \
      -d --restart=always \
      -p "127.0.0.1:${KIND_REGISTRY_PORT}:5000" \
      --network bridge \
      --name "${KIND_REGISTRY_NAME}" \
      registry:2

    echo "Created local image container registry ${KIND_REGISTRY_NAME}:${KIND_REGISTRY_PORT} ✅"
  fi
}

function create_kind_cluster() {
  # Create kind cluster with containerd registry config dir enabled
  kind create cluster --name="${KIND_CLUSTER_NAME}" --config="${SCRIPT_DIR}/cluster.yml"
  echo "Created kind cluster ${KIND_CLUSTER_NAME} ✅"
}

function add_registry_to_nodes() {
  # 3. Add the registry config to the nodes
  #
  # This is necessary because localhost resolves to loopback addresses that are
  # network-namespace local.
  # In other words: localhost in the container is not localhost on the host.
  #
  # We want a consistent name that works from both ends, so we tell containerd to
  # alias localhost:${KIND_REGISTRY_PORT} to the registry container when pulling images

  local REGISTRY_DIR="/etc/containerd/certs.d/localhost:${KIND_REGISTRY_PORT}"

  for NODE in $(kind get nodes --name="${KIND_CLUSTER_NAME}"); do
    docker exec "${NODE}" \
      mkdir -p "${REGISTRY_DIR}"

    cat <<EOF | docker exec -i "${NODE}" cp /dev/stdin "${REGISTRY_DIR}/hosts.toml"
[host."http://${KIND_REGISTRY_NAME}:5000"]
EOF
  done
  echo "Added the registry config to the nodes ✅"
}

function connect_network() {
  # Connect the registry to the cluster network if not already connected
  # This allows kind to bootstrap the network but ensures they're on the same network
  if [ "$(docker inspect -f='{{json .NetworkSettings.Networks.kind}}' "${KIND_REGISTRY_NAME}")" = 'null' ]; then
    docker network connect "kind" "${KIND_REGISTRY_NAME}"
  fi
  echo "Connected the registry to the cluster network ✅"
}

function add_registry_configmap() {
  export KIND_REGISTRY_PORT
  # Add registry configMap
  # https://github.com/kubernetes/enhancements/tree/master/keps/sig-cluster-lifecycle/generic/1755-communicating-a-local-registry
  envsubst <"${SCRIPT_DIR}/registry.yml" | kubectl apply -f -
  echo "Added registry configMap ✅"
}

function destroy_cluster() {
  kind delete cluster --name="${KIND_CLUSTER_NAME}"
  echo "Cluster \"${KIND_CLUSTER_NAME}\" delete ❌"
}

{ # try
  create_container_registry
  create_kind_cluster
  add_registry_to_nodes
  connect_network
  add_registry_configmap
} || { # catch
  destroy_cluster
}
