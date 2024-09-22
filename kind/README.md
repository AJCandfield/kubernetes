# Start a local cluster

We use `kind` to start a local cluster.

## Customisation

Instead of using the default installation, we modify a few attributes to:

- Use a local image registry
- Use a different CNI plugin instead of using`kindnet`

## Local registry

In typical Kubernetes installations, using a local registry is not required. However, since we are using a `kind` cluster for local development and testing, we will deploy one.

Run the script [`start.sh`](./start.sh) in this directory to set up the cluster:

```bash
./start.sh
```

The [`config.yml`](./config.yml) contains a YAML definition which follows a schema used by `kind`.

To disable the default CNI, we include `disableDefaultCNI: true` in the configuration file ([docs](https://kind.sigs.k8s.io/docs/user/configuration/#disable-default-cni)).

## Install Calico

Following the official [docs](https://docs.tigera.io/calico/latest/getting-started/kubernetes/helm#how-to), we install Calico using Helm.

To keep track of the Helm release, we use a `helmfile`. To install Calico:

```bash
helmfile apply
```

It might take about 10 minutes for all containers to be created and be stable.

More info here: <https://docs.tigera.io/calico/latest/getting-started/kubernetes/kind>
