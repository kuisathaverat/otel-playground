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
2025-04-11T11:36:55.356Z        warn    router/transformer.go:66        Running expression returned an error    {"operator_id": "choose-operator", "operator_type": "router", "entry.timestamp": "2025-04-11T11:36:55.337Z", "logtag": "F", "log.file.path": "/var/log/pods/default_apache-7b8dc8dc56-mjg6t_10a61802-2841-4492-850d-d5cec6801b51/apache/0.log", "log.iostream": "stdout", "error": "invalid operation: string - <nil> (1:9)\n | not(body-message matches \"^\\\\[.*\")\n | ........^"}
2025-04-11T11:36:55.577Z        info    Logs    {"resource logs": 1, "log records": 1}
2025-04-11T11:36:55.577Z        info    ResourceLog #0
Resource SchemaURL:
Resource attributes:
     -> k8s.container.name: Str(apache)
     -> k8s.namespace.name: Str(default)
     -> k8s.pod.name: Str(apache-7b8dc8dc56-mjg6t)
     -> k8s.container.restart_count: Str(0)
     -> k8s.pod.uid: Str(10a61802-2841-4492-850d-d5cec6801b51)
ScopeLogs #0
ScopeLogs SchemaURL:
InstrumentationScope
LogRecord #0
ObservedTimestamp: 2025-04-11 11:36:55.355721562 +0000 UTC
Timestamp: 2025-04-11 11:36:55.337742535 +0000 UTC
SeverityText:
SeverityNumber: Unspecified(0)
Body: Str(10.1.47.1 - - [11/Apr/2025:11:36:55 +0000] "GET / HTTP/1.1" 200 45)
Attributes:
     -> log.file.path: Str(/var/log/pods/default_apache-7b8dc8dc56-mjg6t_10a61802-2841-4492-850d-d5cec6801b51/apache/0.log)
     -> log.iostream: Str(stdout)
     -> logtag: Str(F)
Trace ID:
Span ID:
Flags: 0
```
