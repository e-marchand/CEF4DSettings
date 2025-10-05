// Reload Button object method

If (Form event code:C388=On Clicked:K2:4)
	If (Form:C1466.modified)
		CONFIRM:C162("You have unsaved changes. Are you sure you want to reload?"; "Reload"; "Cancel")
		
		If (OK=1)
			cs:C1710.CEFParametersEditor.me.loadParameters()
			Form:C1466.modified:=False:C215
		End if 
	Else 
		cs:C1710.CEFParametersEditor.me.loadParameters()
	End if 
End if 
