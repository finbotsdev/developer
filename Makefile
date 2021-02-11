-include $(shell curl -sSL -o .build-harness "https://raw.githubusercontent.com/opsbot/build-harness/main/templates/Makefile.build-harness"; echo .build-harness)

.DEFAULT_GOAL := bootstrap

## install project requirements
bootstrap: init .vars manifest/pull manifest/make
.PHONY: bootstrap

minikube:
	minikube start

develop: minikube
	skaffold dev

deploy: minikube
	scaffold deploy
