-include $(shell curl -sSL -o .build-harness "https://raw.githubusercontent.com/opsbot/build-harness/master/templates/Makefile.build-harness"; echo .build-harness)

.DEFAULT_GOAL := bootstrap

## install project requirements
bootstrap: init .vars brew
	./bin/setup
	./bin/bootstrap
.PHONY: bootstrap
