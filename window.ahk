; The current active window
global $CurrentWindow := ""

; The previous active window
global $PreviousWindow := ""

IsWindowChanged()
{
	return $CurrentWindow <> $PreviousWindow
}