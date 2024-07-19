# CEFParameters

 edit 4D cef parameters file with code

```4d
var $parameters:=CEFParameters.CEFParameters.me.getParameters()

$parameters.switches["a-valid-key"]:="a valid value"

CEFParameters.CEFParameters.me.setParameters($parameters)
```
