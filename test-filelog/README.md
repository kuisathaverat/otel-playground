# k8s_observer extension

Test minimal requirement configuration to use the [filelog receiver](https://github.com/open-telemetry/opentelemetry-collector-contrib/tree/main/receiver/filelogreceiver).

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

## Log results

This test uses the debug exporter to show how the log results look like.

for the log line `10.1.46.1 - - [04/Apr/2025:15:00:54 +0000] "GET / HTTP/1.1" 200 45` the following snippet is expected:

```log
2025-04-04T15:00:54.799Z        info    ResourceLog #0
Resource SchemaURL:
Resource attributes:
     -> k8s.container.name: Str(apache)
     -> k8s.namespace.name: Str(oteldemo-oanrf-default)
     -> k8s.pod.name: Str(apache-7b8dc8dc56-wfwtf)
     -> k8s.container.restart_count: Str(0)
     -> k8s.pod.uid: Str(30639f85-44b3-4438-80ae-99a1297e742b)
ScopeLogs #0
ScopeLogs SchemaURL:
InstrumentationScope
LogRecord #0
ObservedTimestamp: 2025-04-04 15:00:54.52243288 +0000 UTC
Timestamp: 2025-04-04 15:00:54.514243451 +0000 UTC
SeverityText:
SeverityNumber: Unspecified(0)
Body: Str(10.1.46.1 - - [04/Apr/2025:15:00:54 +0000] "GET / HTTP/1.1" 200 45)
Attributes:
     -> log.file.path: Str(/var/log/pods/oteldemo-oanrf-default_apache-7b8dc8dc56-wfwtf_30639f85-44b3-4438-80ae-99a1297e742b/apache/0.log)
     -> log.iostream: Str(stdout)
     -> logtag: Str(F)
     -> http_code: Str(200)
     -> timestamp_log: Str(04/Apr/2025:15:00:54 +0000)
     -> http_method: Str(GET)
     -> http_path: Str(/)
     -> http_version: Str(HTTP/1.1)
     -> http_size: Str(45)
     -> source_ip: Str(10.1.46.1)
```
