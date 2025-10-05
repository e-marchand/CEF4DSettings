// Form method for CEF Parameters Editor

Case of 
	: (Form event code:C388=On Load:K2:1)
		// Initialize form data
		Form:C1466.platformChoice:=New object:C1471
		Form:C1466.platformChoice.values:=New collection:C1472("all"; "macos"; "win")
		Form:C1466.platformChoice.index:=0
		Form:C1466.platformChoice.currentValue:="all"
		
		Form:C1466.switchesCollection:=New collection:C1472()
		Form:C1466.parameters:=Null:C1517
		Form:C1466.modified:=False:C215
		
		// Load current parameters
		cs:C1710.CEFParametersEditor.me.loadParameters()
		
	: (Form event code:C388=On Close Box:K2:21)
		// Close without saving
		CANCEL:C270
		
	: (Form event code:C388=On Validate:K2:3)
		// Form validated
		
End case 
