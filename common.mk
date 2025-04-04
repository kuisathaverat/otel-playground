SHELL = /bin/bash
MAKEFLAGS += --silent --no-print-directory
.SHELLFLAGS = -ec
.SILENT:

.ONESHELL:

.DEFAULT_GOAL := help

.PHONY: default
default: help

check_defined = \
    $(strip $(foreach 1,$1, \
        $(call __check_defined,$1,$(strip $(value 2)))))
__check_defined = \
    $(if $(value $1),, \
      $(error Undefined $1$(if $2, ($2))))

.PHONY: help
## @help:help:Show this help message
help:
	@grep '^## @help' Makefile|cut -d ":" -f 2-3|( (sort|column -s ":" -t) || (sort|tr ":" "\t") || (tr ":" "\t"))

.PHONY: start-k8s
## @help:start-k8s:Start a Kubernetes cluster using kind
start-k8s:
	@echo "Starting Kubernetes cluster..."
	@kind create cluster --name k8s
	@echo "Kubernetes cluster started."
	kubectl cluster-info --context k8s-kind
	kubectl config use-context k8s-kind

.PHONY: stop-k8s
## @help:stop-k8s:Stop the Kubernetes cluster
stop-k8s:
	@echo "Stopping Kubernetes cluster..."
	@kind delete cluster --name k8s
	@echo "Kubernetes cluster stopped."
