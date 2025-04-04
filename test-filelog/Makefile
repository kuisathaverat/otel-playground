include ../common.mk

.PHONY: deploy
## @help:deploy:Deploy the Apache and OpenTelemetry Collector Helm charts
deploy:
	helm install apache oci://registry-1.docker.io/bitnamicharts/apache --version 11.3.5 --values $(CURDIR)/apache.yml
	helm install collector oci://ghcr.io/open-telemetry/opentelemetry-helm-charts/opentelemetry-collector --version 0.119.1 --values $(CURDIR)/collector.yml

.PHONY: undeploy
## @help:undeploy:Undeploy the Apache and OpenTelemetry Collector Helm charts
undeploy:
	helm uninstall apache --ignore-not-found
	helm uninstall collector --ignore-not-found
