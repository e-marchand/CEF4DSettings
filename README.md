# CEFParameters

 edit 4D cef parameters file with code

```4d
var $parameters:=CEFParameters.CEFParameters.me.getParameters()

$parameters.switches["autoplay-policy"]:="no-user-gesture-required"

CEFParameters.CEFParameters.me.setParameters($parameters)
```
