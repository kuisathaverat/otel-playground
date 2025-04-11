# otel-playground

Repository for experiments and issue replication with OpenTelemetry

## Validate OpenTelemetry Expressions

The OpenTelemetry Collector uses [expr-lang](https://github.com/expr-lang/expr/blob/master/docs/language-definition.md)
to evaluate expressions. This is a Go library we can use to eveluate expressions in Go code.
Because is Go we can test these expressions in Go code before using them in the OpenTelemetry Collector.

We can use the browser and the following snippet to test the expressions:

https://go.dev/play/

```go
package main

import (
	"fmt"

	"github.com/expr-lang/expr"
)

func main() {
	env := map[string]interface{}{
		"text":    `10.1.38.154 - - [03/Apr/2025:12:07:14 +0000] "GET / HTTP/1.1" 500 2431`,
		"output":  "%v",
		"sprintf": fmt.Sprintf,
	}

	code := `sprintf(output, text matches "^\\d.*" )`

	program, err := expr.Compile(code, expr.Env(env))
	if err != nil {
		panic(err)
	}

	output, err := expr.Run(program, env)
	if err != nil {
		panic(err)
	}

	fmt.Println(output)
}
```
