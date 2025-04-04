# k8s_observer extension

Test minimal requirement configuration to use the [k8s_observer extension](https://github.com/open-telemetry/opentelemetry-collector-contrib/blob/main/extension/observer/k8sobserver/README.md).

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

The results are different than the filelog using the same configuration. The `regexp_parser` does not work as expected.

```log
2025-04-04T15:17:23.861Z        error   helper/transformer.go:122       Failed to process entry {"name": "filelog/308d875f-50e6-49ae-8a54-731e425f2e0e_apache/receiver_creator/logs{endpoint=\"10.1.46.13\"}/k8s_observer/308d875f-50e6-49ae-8a54-731e425f2e0e/apache", "operator_id": "apache-logs", "operator_type": "regex_parser", "error": "regex pattern does not match", "action": "send", "entry.timestamp": "2025-04-04T15:17:23.856Z", "log.file.path": "/var/log/pods/oteldemo-oanrf-default_apache-6d8c49ff46-9mftt_308d875f-50e6-49ae-8a54-731e425f2e0e/apache/0.log", "log.iostream": "stdout", "logtag": "F"}
github.com/open-telemetry/opentelemetry-collector-contrib/pkg/stanza/operator/helper.(*TransformerOperator).HandleEntryError
        github.com/open-telemetry/opentelemetry-collector-contrib/pkg/stanza@v0.123.0/operator/helper/transformer.go:122
github.com/open-telemetry/opentelemetry-collector-contrib/pkg/stanza/operator/helper.(*ParserOperator).ParseWith
        github.com/open-telemetry/opentelemetry-collector-contrib/pkg/stanza@v0.123.0/operator/helper/parser.go:142
github.com/open-telemetry/opentelemetry-collector-contrib/pkg/stanza/operator/helper.(*ParserOperator).ProcessWithCallback
        github.com/open-telemetry/opentelemetry-collector-contrib/pkg/stanza@v0.123.0/operator/helper/parser.go:111
github.com/open-telemetry/opentelemetry-collector-contrib/pkg/stanza/operator/helper.(*ParserOperator).ProcessWith
        github.com/open-telemetry/opentelemetry-collector-contrib/pkg/stanza@v0.123.0/operator/helper/parser.go:98
github.com/open-telemetry/opentelemetry-collector-contrib/pkg/stanza/operator/parser/regex.(*Parser).Process
        github.com/open-telemetry/opentelemetry-collector-contrib/pkg/stanza@v0.123.0/operator/parser/regex/parser.go:35
github.com/open-telemetry/opentelemetry-collector-contrib/pkg/stanza/operator/helper.(*WriterOperator).Write
        github.com/open-telemetry/opentelemetry-collector-contrib/pkg/stanza@v0.123.0/operator/helper/writer.go:73
github.com/open-telemetry/opentelemetry-collector-contrib/pkg/stanza/operator/parser/container.(*Parser).consumeEntries
        github.com/open-telemetry/opentelemetry-collector-contrib/pkg/stanza@v0.123.0/operator/parser/container/parser.go:298
github.com/open-telemetry/opentelemetry-collector-contrib/pkg/stanza/operator/helper.(*BatchingLogEmitter).flusher
        github.com/open-telemetry/opentelemetry-collector-contrib/pkg/stanza@v0.123.0/operator/helper/emitter.go:171
2025-04-04T15:17:23.862Z        error   container/parser.go:300 failed to write entry   {"name": "filelog/308d875f-50e6-49ae-8a54-731e425f2e0e_apache/receiver_creator/logs{endpoint=\"10.1.46.13\"}/k8s_observer/308d875f-50e6-49ae-8a54-731e425f2e0e/apache", "operator_id": "container-parser", "operator_type": "container", "error": "regex pattern does not match"}
github.com/open-telemetry/opentelemetry-collector-contrib/pkg/stanza/operator/parser/container.(*Parser).consumeEntries
        github.com/open-telemetry/opentelemetry-collector-contrib/pkg/stanza@v0.123.0/operator/parser/container/parser.go:300
github.com/open-telemetry/opentelemetry-collector-contrib/pkg/stanza/operator/helper.(*BatchingLogEmitter).flusher
        github.com/open-telemetry/opentelemetry-collector-contrib/pkg/stanza@v0.123.0/operator/helper/emitter.go:171
2025-04-04T15:17:23.980Z        info    Logs    {"resource logs": 2, "log records": 2}
2025-04-04T15:17:23.980Z        info    ResourceLog #0
Resource SchemaURL:
Resource attributes:
     -> k8s.container.restart_count: Str(0)
     -> k8s.pod.uid: Str(308d875f-50e6-49ae-8a54-731e425f2e0e)
     -> k8s.container.name: Str(apache)
     -> k8s.namespace.name: Str(oteldemo-oanrf-default)
     -> k8s.pod.name: Str(apache-6d8c49ff46-9mftt)
ScopeLogs #0
ScopeLogs SchemaURL:
InstrumentationScope
LogRecord #0
ObservedTimestamp: 2025-04-04 15:17:23.863873858 +0000 UTC
Timestamp: 2025-04-04 15:17:23.856663589 +0000 UTC
SeverityText:
SeverityNumber: Unspecified(0)
Body: Str(10.1.46.1 - - [04/Apr/2025:15:17:23 +0000] "GET / HTTP/1.1" 200 45)
Attributes:
     -> log.iostream: Str(stdout)
     -> logtag: Str(F)
     -> log.file.path: Str(/var/log/pods/oteldemo-oanrf-default_apache-6d8c49ff46-9mftt_308d875f-50e6-49ae-8a54-731e425f2e0e/apache/0.log)
Trace ID:
Span ID:
Flags: 0
ResourceLog #1
Resource SchemaURL:
Resource attributes:
     -> k8s.container.name: Str(apache)
     -> k8s.namespace.name: Str(oteldemo-oanrf-default)
     -> k8s.pod.name: Str(apache-6d8c49ff46-9mftt)
     -> k8s.container.restart_count: Str(0)
     -> k8s.pod.uid: Str(308d875f-50e6-49ae-8a54-731e425f2e0e)
     -> container.id: Str(ed1cd5fb4ae33458cfa34d984d84000d65661442c5144aeb07c4e0372ce27848)
     -> container.image.name: Str(docker.io/bitnami/apache:2.4.63-debian-12-r7)
ScopeLogs #0
ScopeLogs SchemaURL:
InstrumentationScope
LogRecord #0
ObservedTimestamp: 2025-04-04 15:17:23.861723778 +0000 UTC
Timestamp: 2025-04-04 15:17:23.856663589 +0000 UTC
SeverityText:
SeverityNumber: Unspecified(0)
Body: Str(10.1.46.1 - - [04/Apr/2025:15:17:23 +0000] "GET / HTTP/1.1" 200 45)
Attributes:
     -> log.file.path: Str(/var/log/pods/oteldemo-oanrf-default_apache-6d8c49ff46-9mftt_308d875f-50e6-49ae-8a54-731e425f2e0e/apache/0.log)
     -> log.iostream: Str(stdout)
     -> logtag: Str(F)
Trace ID:
Span ID:
Flags: 0
```
