# CEFParameters

 edit 4D cef parameters file with code

```4d
CEFParameters.CEFParameters.me.set("autoplay-policy"; "no-user-gesture-required")
// or cs. if imported code into your base
```

or for full control

```4d
var $parameters:=CEFParameters.CEFParameters.me.getParameters()

$parameters.switches["autoplay-policy"]:="no-user-gesture-required"

CEFParameters.CEFParameters.me.setParameters($parameters)
```
