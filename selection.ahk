CopySelection( showWarning = false )
{
	cbCopy := ClipboardAll
	Clipboard=
	
	SendInput, ^{Insert}
  ClipWait, 0.5
	
	If ErrorLevel
	{
		if %showWarning%
		{
      s := _t("The attempt to copy text onto the clipboard failed.")
      if(!s)
        s := "The attempt to copy text onto the clipboard failed."
			MsgBox, %s%
			Return
		}
	}
	else
	{
		if Clipboard=
			if %showWarning%
			{
				s := _t("The attempt to copy text onto the clipboard failed.")
        if(!s)
          s := "The attempt to copy text onto the clipboard failed."
  			MsgBox, %s%
				Return
			}
	}
	result:=Clipboard
	Clipboard:=cbCopy
	Return result
}