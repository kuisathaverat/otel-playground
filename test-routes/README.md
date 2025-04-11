# Router operator

Test minimal requirement configuration to use the [filelog receiver](https://github.com/open-telemetry/opentelemetry-collector-contrib/tree/main/receiver/filelogreceiver) and route messages based on the content of the message.

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
The `not()` or `!()` expresions are not correctly evaluated in the current version of the router operator.

for the log line `10.1.47.1 - - [11/Apr/2025:11:36:55 +0000] "GET / HTTP/1.1" 200 45` the following snippet is expected:

```log
2025-04-11T14:59:02.928Z        info    Logs    {"resource logs": 1, "log records": 1}
2025-04-11T14:59:02.928Z        info    ResourceLog #0
Resource SchemaURL:
Resource attributes:
     -> k8s.pod.uid: Str(6ff079f6-8f67-4900-a684-0eef2e118cf1)
     -> k8s.container.name: Str(apache)
     -> k8s.namespace.name: Str(default)
     -> k8s.pod.name: Str(apache-7b8dc8dc56-trpzr)
     -> k8s.container.restart_count: Str(0)
ScopeLogs #0
ScopeLogs SchemaURL:
InstrumentationScope
LogRecord #0
ObservedTimestamp: 2025-04-11 14:59:02.627892166 +0000 UTC
Timestamp: 2025-04-11 14:59:02.587253662 +0000 UTC
SeverityText:
SeverityNumber: Unspecified(0)
Body: Str(10.1.47.1 - - [11/Apr/2025:14:59:02 +0000] "GET / HTTP/1.1" 200 45)
Attributes:
     -> log.iostream: Str(stdout)
     -> msg: Str(10.1.47.1 - - [11/Apr/2025:14:59:02 +0000] "GET / HTTP/1.1" 200 45)
     -> expr: Bool(true)
     -> test: Str(match)
     -> log.file.path: Str(/var/log/pods/default_apache-7b8dc8dc56-trpzr_6ff079f6-8f67-4900-a684-0eef2e118cf1/apache/0.log)
     -> logtag: Str(F)
Trace ID:
Span ID:
Flags: 0
```
