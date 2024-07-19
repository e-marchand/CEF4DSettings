//%attributes = {}


var $defaultFile:=cs:C1710.CEFParameters.me.getDefaultFile()
var $file:=cs:C1710.CEFParameters.me.getFile()

If (Not:C34($file.exists))
	$defaultFile.copyTo($file.parent; $file.fullName)
End if 

var $parameters:=cs:C1710.CEFParameters.me.getParameters()

$parameters.switches["remote-allow-origins"]:="http://localhost:8888"

cs:C1710.CEFParameters.me.setParameters($parameters)


