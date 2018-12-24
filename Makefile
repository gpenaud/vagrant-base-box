.ONESHELL:

distribution 			= debian
version 					?= $(filter-out $@,$(MAKECMDGOALS))
available_versions ?= jessie stretch

## HELP
PROJECT           = Vagrant-Base-Boxes-Creator
## Colors
COLOR_RESET       = $(shell tput sgr0)
COLOR_ERROR       = $(shell tput setaf 1)
COLOR_INFO        = $(shell tput setaf 2)
COLOR_COMMENT     = $(shell tput setaf 3)
COLOR_TITLE_BLOCK = $(shell tput setab 4)

## check that configuration is set-up correctly (network, etc...)
test:
	@bash scripts/tests

## create vagrant images for lxc containers
container:
ifeq ($(words $(version)), 2)
	bash generate-base-boxes --provider=lxc --distribution=${distribution} --version=${version}
else
	bash generate-base-boxes --provider=lxc --distribution=${distribution}
endif

## create vagrant images for qemu/libvirt
vm:
ifeq ($(words $(version)), 2)
	bash generate-base-boxes --provider=libvirt --distribution=${distribution} --version=${version}
else
	bash generate-base-boxes --provider=libvirt --distribution=${distribution}
endif

## display this help text
help:
	@printf "\n"
	@printf "${COLOR_TITLE_BLOCK}${PROJECT} Makefile${COLOR_RESET}\n"
	@printf "\n"
	@printf "${COLOR_COMMENT}Usage:${COLOR_RESET}\n"
	@printf " make [provider] [version (optionnal)]\n\n"
	@printf "${COLOR_COMMENT}Available targets:${COLOR_RESET}\n"
	@awk '/^[a-zA-Z\-\_0-9\@]+:/ { \
				helpLine = match(lastLine, /^## (.*)/); \
				helpCommand = substr($$1, 0, index($$1, ":")); \
				helpMessage = substr(lastLine, RSTART + 3, RLENGTH); \
				printf " ${COLOR_INFO}%-30s${COLOR_RESET} %s\n", helpCommand, helpMessage; \
		} \
		{ lastLine = $$0 }' $(MAKEFILE_LIST)
	@printf "\n"
