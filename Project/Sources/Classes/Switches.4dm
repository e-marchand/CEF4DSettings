

Class constructor($data : Object)
	If ($data=Null:C1517)
		return 
	End if 
	var $key : Text
	For each ($key; $data)
		This:C1470[$key]:=$data[$key]
	End for each 