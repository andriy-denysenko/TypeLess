; This list is used to check if a given key is valid to avoid unhandled exceptions.
global _VALID_KEYS := "{F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{F13}{F14}{F15}{F16}{F17}{F18}{F19}{F20}{F21}{F22}{F23}{F24}{Enter}{Esc}{Space}{Tab}{Backspace}{Del}{Ins}{Up}{Down}{Left}{Right}{Home}{End}{PgUp}{PgDn}{CapsLock}{ScrollLock}{NumLock}{Ctrl}{LCtrl}{RCtrl}{Alt}{LAlt}{RAlt}{Shift}{LShift}{RShift}{LWin}{RWin}{AppsKey}{Sleep}{Numpad0}{Numpad1}{Numpad2}{Numpad3}{Numpad4}{Numpad5}{Numpad6}{Numpad7}{Numpad8}{Numpad9}{NumpadDot}{NumpadEnter}{NumpadMult}{NumpadDiv}{NumpadAdd}{NumpadSub}{NumpadDel}{NumpadIns}{NumpadClear}{NumpadUp}{NumpadDown}{NumpadLeft}{NumpadRight}{NumpadHome}{NumpadEnd}{NumpadPgUp}{NumpadPgDn}{Browser_Back}{Browser_Forward}{Browser_Refresh}{Browser_Stop}{Browser_Search}{Browser_Favorites}{Browser_Home}{Volume_Mute}{Volume_Down}{Volume_Up}{Media_Next}{Media_Prev}{Media_Stop}{Media_Play_Pause}{Launch_Mail}{Launch_Media}{Launch_App1}{Launch_App2}{PrintScreen}{CtrlBreak}{Pause}"

;
; Function: Brace
; Description:
;		Encloses the supplied key in braces if it has no braces.
; Syntax: strKey := Brace(strKey)
; Parameters:
;		strKey - A key name to enclose in braces.
; Return Value:
; 		A key name in braces.
; Example:
;		strKey := Brace("Enter")
;
Brace(strKey)
{
	if(SubStr(strKey, 1, 1) <> "{" && SubStr(strKey, 0, 1) <> "}")
		strKey = {%strKey%}
	
	return strKey
}

;
; Function: IsKeyValid
; Description:
;		Determines if a supplied key is one of supported AutoHotkey keys
; Syntax: valid := IsKeyValid(strKey)
; Parameters:
;		strKey - A key according to the "List of Keys, Mouse Buttons, and Joystick Controls" section in the AutoHotkey_L documentation.
; 			It may be specified with or without braces.
; Return Value:
; 		Returns true if the specified key is valid or false otherwise.
; Example:
;		if(IsKeyValid("{Enter}"))
;				MsgBox, {Enter} is a valid key
;

IsKeyValid(strKey)
{
  global _VALID_KEYS
	strKey := Brace(strKey)
	return InStr(_VALID_KEYS, strKey) > 0
}
