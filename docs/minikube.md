# minikube

see [minikube quickstart](https://minikube.sigs.k8s.io/docs/start/) for more information.

## Create a minikube cluster

`minikube start`

## Open the Kubernetes dashboard in a browser

`minikube dashboard`

## Enable addons

The minikube tool includes a set of built-in addons that can be enabled, disabled and opened in the local Kubernetes environment.

- List the currently supported addons `minikube addons list`
- Enable an addon, for example, metrics-server `minikube addons enable metrics-server`
- Disable an addon, for example, metrics-server `minikube addons disable metrics-server`

## clean up

Optionally, stop the Minikube virtual machine `minikube stop`
Optionally, delete the Minikube virtual machine `minikube delete`
