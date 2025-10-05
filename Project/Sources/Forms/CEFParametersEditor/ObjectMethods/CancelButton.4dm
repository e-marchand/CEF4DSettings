// Cancel Button object method

If (Form event code:C388=On Clicked:K2:4)
	If (Form:C1466.modified)
		CONFIRM:C162("You have unsaved changes. Are you sure you want to cancel?"; "Yes"; "No")
		
		If (OK=1)
			CANCEL:C270
		End if 
	Else 
		CANCEL:C270
	End if 
End if 
