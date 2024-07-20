
singleton Class constructor
	
Function getDefaultFile() : 4D:C1709.File
	Case of 
		: (Is macOS:C1572)
			return Folder:C1567(Application file:C491; fk platform path:K87:2).file("Contents/Resources/4DCEFParameters.json")
		Else 
			return File:C1566(Application file:C491; fk platform path:K87:2).parent.file("Resources/4DCEFParameters.json")
	End case 
	
Function getFile() : 4D:C1709.File
	return Folder:C1567(fk user preferences folder:K87:10).file("4DCEFParameters.json")
	
	
Function getDefaultParameters : Object
	return This:C1470._parse(This:C1470.getDefaultFile())
	
	
Function getParameters : Object
	return This:C1470._parse(This:C1470.getFile())
	
Function setParameters($parameters : Object)
	This:C1470._throwIfNotValid($parameters)
	This:C1470.getFile().setText(JSON Stringify:C1217($parameters; *))
	
Function set($key : Text; $value : Variant)
	var $data:=This:C1470.getParameters()
	$data.switches.set($key; $value)
	This:C1470.setParameters($data)
	
Function toggle($key : Text)
	var $data:=This:C1470.getParameters()
	$data.switches.toggle($key)
	This:C1470.setParameters($data)
	
Function get($key : Text) : Variant
	var $data:=This:C1470.getParameters()
	return $data.switches.get($key)
	
	
	// MARk:- private
	
Function _parse($file : 4D:C1709.File) : Object
	var $data : Object
	
	If (Not:C34($file.exists))
		$data:={}
	Else 
		$data:=JSON Parse:C1218($file.getText())
	End if 
	
	If (Value type:C1509($data.switches)=Is object:K8:27)
		$data.switches:=cs:C1710.Switches.new($data.switches)
	Else 
		$data.switches:=cs:C1710.Switches.new(Null:C1517)
	End if 
	
	If (Value type:C1509($data.macOS.switches)=Is object:K8:27)
		$data.macOS.switches:=cs:C1710.Switches.new()
	Else 
		$data.macOS:={switches: cs:C1710.Switches.new(Null:C1517)}
	End if 
	
	If (Value type:C1509($data.windows.switches)=Is object:K8:27)
		$data.windows.switches:=cs:C1710.Switches.new($data.windows.switches)
	Else 
		$data.windows:={switches: cs:C1710.Switches.new(Null:C1517)}
	End if 
	
	// ignore all other things
	
	return $data
	
	
Function _throwIfNotValid($parameters : Object)
	
	If ($parameters=Null:C1517)
		throw:C1805(1; "Parameters must not be null")
	End if 
	
	var $valid : Boolean:=(Value type:C1509($parameters.switches)=Is object:K8:27) || (Value type:C1509($parameters.macOS.switches)=Is object:K8:27) || (Value type:C1509($parameters.windows.switches)=Is object:K8:27)
	
	If (Not:C34($valid))
		throw:C1805(2; "Parameters do not contains any switches")
	End if 
	
	// do more check like switches if not null, then must be objects
	
	
	// TODO: functions to add or remove parameters or switches