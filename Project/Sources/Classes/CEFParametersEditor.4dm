singleton Class constructor
	
	
Function loadParameters() : Object
	var $result : Object:={success: True:C214}
	
	Try
		// Load parameters
		Form:C1466.parameters:=cs:C1710.CEFParameters.me.getParameters()
		
		// Clear collection
		Form:C1466.switchesCollection:=New collection:C1472()
		
		// Get switches based on platform selection
		var $switches : Object
		
		Case of 
			: (Form:C1466.platformChoice.index=0)  // All platforms
				$switches:=Form:C1466.parameters.switches
			: (Form:C1466.platformChoice.index=1)  // macOS
				$switches:=Form:C1466.parameters.macOS.switches
			: (Form:C1466.platformChoice.index=2)  // Windows
				$switches:=Form:C1466.parameters.windows.switches
		End case 
		
		// Convert switches object to collection for listbox
		If ($switches#Null:C1517)
			var $key : Text
			For each ($key; $switches)
				var $value : Variant
				$value:=$switches[$key]
				
				// Convert value to text for display
				var $displayValue : Text
				Case of 
					: (Value type:C1509($value)=Is boolean:K8:9)
						If ($value)
							$displayValue:=""  // Empty string represents boolean true
						Else 
							$displayValue:="false"
						End if 
					: (Value type:C1509($value)=Is text:K8:3)
						$displayValue:=$value
					: (Value type:C1509($value)=Is real:K8:4) | (Value type:C1509($value)=Is longint:K8:6)
						$displayValue:=String:C10($value)
					Else 
						$displayValue:=JSON Stringify:C1217($value)
				End case 
				
				Form:C1466.switchesCollection.push({key: $key; value: $displayValue})
			End for each 
			
			// Sort by key name
			Form:C1466.switchesCollection:=Form:C1466.switchesCollection.orderBy("key")
		End if 
		
		Form:C1466.modified:=False:C215
		
	Catch
		var $error : Object
		$error:=Last errors:C1799.first()
		$result.success:=False:C215
		$result.error:=$error.message
		ALERT:C41("Error loading parameters: "+$error.message)
	End try
	
	return $result
	
Function addAction()
	var $key; $value : Text
	var $exists : Boolean
	var $item : Object
	
	$key:=Request:C163("Enter switch name:"; ""; "OK"; "Cancel")
	
	If (OK=1) && ($key#"")
		// Check if key already exists
		$exists:=False:C215
		For each ($item; Form:C1466.switchesCollection)
			If ($item.key=$key)
				$exists:=True:C214
				ALERT:C41("Switch '"+$key+"' already exists!")
			End if 
		End for each 
		
		If (Not:C34($exists))
			$value:=Request:C163("Enter switch value (leave empty for boolean true):"; ""; "OK"; "Cancel")
			
			If (OK=1)
				
				// Add to collection
				Form:C1466.switchesCollection.push({key: $key; value: $value})
				
				// Sort collection by key
				Form:C1466.switchesCollection:=Form:C1466.switchesCollection.orderBy("key")
				
				// Mark as modified
				Form:C1466.modified:=True:C214
			End if 
		End if 
	End if 
	
Function removeAction()
	var $listbox : Pointer
	var $position : Integer
	var $confirm : Integer
	
	$position:=Form:C1466.currentItemPos
	If ($position>0)
		CONFIRM:C162("Are you sure you want to remove this switch?"; "Remove"; "Cancel")
		
		If (OK=1)
			Form:C1466.switchesCollection.remove($position-1)
			Form:C1466.modified:=True:C214
		End if 
	Else 
		ALERT:C41("Please select a switch to remove.")
	End if 
	
Function saveAction()
	Try
		// Create a plain object for switches (not cs.Switches class)
		var $switchesObj : Object
		$switchesObj:={}
		
		// Populate switches from collection
		var $item : Object
		For each ($item; Form:C1466.switchesCollection)
			If ($item.value="")
				$switchesObj[$item.key]:=True:C214
			Else 
				If ($item.value="false")
					$switchesObj[$item.key]:=False:C215
				Else 
					// Try to parse as number, otherwise keep as string
					var $num : Real
					$num:=Num:C11($item.value)
					If (String:C10($num)=$item.value)
						$switchesObj[$item.key]:=$num
					Else 
						$switchesObj[$item.key]:=$item.value
					End if 
				End if 
			End if 
		End for each 
		
		// Build plain object structure based on platform
		var $plainParams : Object
		$plainParams:={}
		
		Case of 
			: (Form:C1466.platformChoice.index=0)  // All platforms
				$plainParams.switches:=$switchesObj
			: (Form:C1466.platformChoice.index=1)  // macOS
				$plainParams.macOS:={switches: $switchesObj}
			: (Form:C1466.platformChoice.index=2)  // Windows
				$plainParams.windows:={switches: $switchesObj}
		End case 
		
		// Save directly to file
		var $file : 4D:C1709.File
		$file:=cs:C1710.CEFParameters.me.getFile()
		$file.setText(JSON Stringify:C1217($plainParams; *))
		
		Form:C1466.modified:=False:C215
		ALERT:C41("Parameters saved successfully!")
		
	Catch
		var $error : Object
		$error:=Last errors:C1799.first()
		ALERT:C41("Error saving parameters: "+Choose:C955($error#Null:C1517; $error.message; "Unknown error"))
	End try