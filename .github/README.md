# ⎈ `kubernetes`

[![Kubernetes](https://img.shields.io/badge/kubernetes-%23326ce5.svg?style=for-the-badge&logo=kubernetes&logoColor=white)](https://kubectl.docs.kubernetes.io/guides/introduction/kubectl/)
[![Docker](https://img.shields.io/badge/docker-%230db7ed.svg?style=for-the-badge&logo=docker&logoColor=white)](https://docs.docker.com/get-started/)

[![Linting](https://github.com/AJCandfield/kubernetes/actions/workflows/lint.yml/badge.svg)](https://github.com/AJCandfield/kubernetes/actions/workflows/lint.yml)

## 🛠️ Tools

It is recommended to install the following tools to use this project:

### [`helm`](https://helm.sh/)

> Helm helps you manage Kubernetes applications.
> Helm Charts help you define, install, and upgrade even the most complex Kubernetes application.

#### Installation

```bash
brew install helm
```

Additionally, install the [`helm-diff`](https://github.com/databus23/helm-diff) plugin:

```bash
helm plugin install https://github.com/databus23/helm-diff
```

### [`helmfile`](https://helmfile.readthedocs.io/en/latest)

> Helmfile is a declarative spec for deploying helm charts.

#### Installation

```bash
brew install helmfile
```

### [`kustomize`](https://kubectl.docs.kubernetes.io/guides/introduction/kustomize/)

> `kustomize` provides a solution for customizing Kubernetes resource configuration free from templates and DSLs.
> `kustomize` lets you customize raw, template-free YAML files for multiple purposes,
> leaving the original YAML untouched and usable as is.

#### Installation

```bash
brew install kustomize
```

### [`kubectl`](https://kubectl.docs.kubernetes.io/guides/introduction/kubectl/)

> `kubectl` is the Kubernetes cli version of a swiss army knife, and can do many things.

#### Installation

```bash
brew install kubectl
```

### [`orbstack`](https://docs.orbstack.dev/)

> OrbStack is a fast, light, and simple way to run containers and Linux machines.
> It's a supercharged alternative to Docker Desktop and WSL, all in one easy-to-use app.

#### Installation

```bash
brew install orbstack
```

### [`kind`](https://kind.sigs.k8s.io/)

> `kind` is a tool for running local Kubernetes clusters
> using Docker container “nodes”.
> `kind` was primarily designed for testing Kubernetes itself,
> but may be used for local development or CI.

#### Installation

```bash
brew install kind
```

### [`tilt`](https://tilt.dev/)

> Modern apps are made of too many services.
> They’re everywhere and in constant communication.
> Tilt powers microservice development and makes sure they behave!
> Run `tilt up` to work in a complete dev environment configured for your team.

#### Installation

```bash
brew install tilt-dev/tap/tilt
```

### [`ctlptl`](https://github.com/tilt-dev/ctlptl)

> `ctlptl` is a CLI for declaratively setting up local Kubernetes clusters.

#### Installation

```bash
brew install tilt-dev/tap/ctlptl
```
