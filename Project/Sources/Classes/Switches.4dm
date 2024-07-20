Class constructor($data : Object)
	If ($data=Null:C1517)
		return 
	End if 
	var $key : Text
	For each ($key; $data)
		This:C1470[$key]:=$data[$key]
	End for each 
	
Function set($key : Text; $value : Variant)
	This:C1470[$key]:=$value
	
Function toggle($key : Text)
	Case of 
		: (This:C1470[$key]=Null:C1517)
			This:C1470[$key]:=True:C214
		: (Value type:C1509(This:C1470[$key])=Is boolean:K8:9)
			This:C1470[$key]:=Not:C34(This:C1470[$key])
		Else 
			This:C1470[$key]:=True:C214
	End case 
	
Function get($key : Text) : Variant
	return This:C1470[$key]