; The last pressed key
global $LastKey := ""

; The last entered character
global $LastChar := ""

global $ResetRequired := false
	
; Working flag
global $Working := false

; Input buffer
global $Buffer := ""

global $LastTypedWord := ""

StartInputFiltering()
{
  global
;   OutputDebug, InputFilter Start
	if($Working)
		return
	
  local char
  
	$Buffer := ""
	$Working := true
	
	$PreviousWindow := WinExist("A")
	$CurrentWindow := WinExist("A")
	
	; Enable hotkeys
	
	;~ OutputDebug, Enabling hotkeys
	
	Hotkey, ~LButton Up, LButtonUp, On
	Hotkey, ~MButton Up, MButtonUp, On
	Hotkey, ~RButton Up, RButtonUp, On
	
	while ($Working = true)
	{
		; Input a single character or key
; 		Input, char, C I L1 V, % _WatchedKeys, % _WatchedChars
;     The following line is used instead of the previous one when testing
    Input, char, C L1 V, % _WatchedKeys, % _WatchedChars
		
		; Trigger events
		if ErrorLevel = Max
		{
; 			OutputDebug, Max: Last char = %char%
			$LastChar := char
      $LastKey := ""
			TriggerInputEvent("Max")
		}
		else if ErrorLevel = Match
		{
;       OutputDebug, Match: Last char = %char%
			$LastChar := char
      $LastKey := ""
			TriggerInputEvent("Match")
		}
		else IfInString, ErrorLevel, EndKey:
		{
			StringSplit, EndKeyString, ErrorLevel, :
			$LastKey := EndKeyString2
      $LastChar := ""
;       OutputDebug, EndKey: Last key = %$LastKey%
			TriggerInputEvent("EndKey")
		}
	}
}

StopInputFiltering()
{
	;~ OutputDebug, InputFilter Stopping
	$Working := false
	Hotkey, ~LButton Up, Off
	Hotkey, ~MButton Up, Off
	Hotkey, ~RButton Up, Off
}