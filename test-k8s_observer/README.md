# k8s_observer extension

Test minimal requirement configuration to use the [k8s_observer extension](https://github.com/open-telemetry/opentelemetry-collector-contrib/blob/main/extension/observer/k8sobserver/README.md).

## Requirements

* Kubernetes cluster up and running
* Kubernetes CLI (kubectl) installed and configured to access the cluster
* Helm CLI installed

## Deploy the k8s_observer extension

```shell
make deploy
```

## Uninstall the k8s_observer extension

```shell
make undeploy
```
