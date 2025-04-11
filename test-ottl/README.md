# OTTL

Test minimal requirement configuration to use the [filelog receiver](https://github.com/open-telemetry/opentelemetry-collector-contrib/tree/main/receiver/filelogreceiver) and use [OTTL](https://github.com/open-telemetry/opentelemetry-collector-contrib/tree/main/pkg/ottl) to parse the logs.

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

for the log line `10.1.47.1 - - [11/Apr/2025:16:12:06 +0000] "GET / HTTP/1.1" 200 45` the following snippet is expected:

```log
2025-04-11T16:12:06.511Z        info    Logs    {"resource logs": 1, "log records": 1}
2025-04-11T16:12:06.511Z        info    ResourceLog #0
Resource SchemaURL:
Resource attributes:
     -> k8s.namespace.name: Str(default)
     -> k8s.pod.name: Str(apache-7b8dc8dc56-fq28g)
     -> k8s.container.restart_count: Str(0)
     -> k8s.pod.uid: Str(8ba7b636-4863-496d-a004-853d207bda2e)
     -> k8s.container.name: Str(apache)
     -> type: Str(access_log)
ScopeLogs #0
ScopeLogs SchemaURL:
InstrumentationScope
LogRecord #0
ObservedTimestamp: 2025-04-11 16:12:06.238602587 +0000 UTC
Timestamp: 2025-04-11 16:12:06.150147889 +0000 UTC
SeverityText:
SeverityNumber: Unspecified(0)
Body: Str(10.1.47.1 - - [11/Apr/2025:16:12:06 +0000] "GET / HTTP/1.1" 200 45)
Attributes:
     -> log.file.path: Str(/var/log/pods/default_apache-7b8dc8dc56-fq28g_8ba7b636-4863-496d-a004-853d207bda2e/apache/0.log)
     -> log.iostream: Str(stdout)
     -> logtag: Str(F)
     -> source_ip: Str(10.1.47.1)
     -> timestamp_log: Str(11/Apr/2025:16:12:06 +0000)
     -> http_method: Str(GET)
     -> http_path: Str(/)
     -> http_version: Str(HTTP/1.1)
     -> http_code: Str(200)
     -> http_size: Str(45)
Trace ID:
Span ID:
Flags: 0
```

It is possible to test the OTTL with [OTTL Playground](https://ottl.run/)
