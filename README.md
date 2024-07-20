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

> ⚠️ after editing, we need to restart the 4D app

## Links

- https://developer.4d.com/docs/FormObjects/webAreaOverview/#4dcefparametersjson
- https://blog.4d.com/custom-parameters-for-initializing-embedded-web-area/
