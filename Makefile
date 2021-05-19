-include $(shell curl -sSL -o .build-harness "https://raw.githubusercontent.com/opsbot/build-harness/main/templates/Makefile.build-harness"; echo .build-harness)

.DEFAULT_GOAL := bootstrap

## install project requirements
bootstrap: init .vars \
	manifest/pull \
	manifest/make \
	helm
.PHONY: bootstrap

helm:
	helm repo add bitnami https://charts.bitnami.com/bitnami
	helm repo add localstack https://localstack.github.io/helm-charts

minikube:
	minikube start

develop: minikube
	skaffold dev

deploy: minikube
	scaffold deploy
