; These keys are used as EndKeys parameter for the Input command.
; Some of them may be used as ending characters for phrase insertion, others may reset the hotstring recognizer.
; _DEF_WATCHED_KEYS do not include Enter, Tab & Space which should be appended if necessary to _WatchedKeys
global _DEF_WATCHED_KEYS := "{F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{F13}{F14}{F15}{F16}{F17}{F18}{F19}{F20}{F21}{F22}{F23}{F24}{Backspace}{Esc}{Del}{Ins}{Up}{Down}{Left}{Right}{Home}{End}{PgUp}{PgDn}{LCtrl}{RCtrl}{LAlt}{RAlt}{LWin}{RWin}{AppsKey}{Sleep}{NumpadEnter}{NumpadDel}{Browser_Back}{Browser_Forward}{Browser_Refresh}{Browser_Stop}{Browser_Search}{Browser_Favorites}{Browser_Home}{Volume_Mute}{Volume_Down}{Volume_Up}{Media_Next}{Media_Prev}{Media_Stop}{Media_Play_Pause}{Launch_Mail}{Launch_Media}{Launch_App1}{Launch_App2}{WheelUp}{WheelDown}"
global _WatchedKeys := _DEF_WATCHED_KEYS

;
; Function: IsWatchedKey
; Description:
;		Determines if a character is watched.
; Syntax: flag := IsWatchedKey(key)
; Parameters:
;		key - A key that is checked.
; Return Value:
; 	Returns true if a key is a watched key, or false otherwise.
; Related: AddWatchedKeys
;
IsWatchedKey(key)
{
  global _WatchedKeys
  bkey := Brace(key)
  if(InStr(_WatchedKeys, bkey))
    return true
  else
    return false
}

;
; Function: AddWatchedKeys
; Description:
;		Adds keys to be watched by the filter. These are usually used as ending keys.
; Syntax: AddWatchedKeys(newKeys)
; Parameters:
;		newKeys - An array object or a pipe-delimited string containing key names to be watched.
; Return Value:
; 	Returns no value on success. If any key is invalid, returns that key and sets ErrorLevel to 1.
; Related: AddWatchedChars
; Remarks:
;   Sets ErrorLevel to 1 if any key is invalid and returns that key.
; Example:
;		AddWatchedKeys(["{Enter}", "{Tab}", "{Space}"])
;		AddWatchedKeys("Enter|Tab|Space")
;   If !ErrorLevel
;       msgbox, Success!
;
AddWatchedKeys(newKeys)
{
  global _WatchedKeys
;   OutputDebug In AddWatchedKeys(%newKeys%)
  if(!IsObject(newKeys))
  {
;     OutputDebug `tCalling AddWatchedKeysPA
    StringSplit, parrKeys, newKeys, |

  	; Loop through keys
  	Loop, %parrKeys0%
  	{
  		; Enclose the key name into braces
  		key := Brace(parrKeys%A_Index%)
  		
;       OutputDebug Checking key %key%
  		; Move to the next key if the current key is already watched
  		if(InStr(_WatchedKeys, key))
  			continue
  		
  		; Invalid keys are not inserted. They are returned in an array object.
  		if(!IsKeyValid(key))
  		{
  			ErrorLevel = 1
  			return key
  		}
;   		OutputDebug Adding key %key%
  		; Append the key to watched keys
  		_WatchedKeys .= key
  	}
  	return result
  }
  else
  {    
  	; Loop through keys
  	for index, key in newKeys
  	{
  		; Enclose the key name into braces
  		key := Brace(key)
  		
  		; Move to the next key if the current key is already watched
  		if(InStr(_WatchedKeys, key))
  			continue
  		
  		; Invalid keys are not inserted. They are returned in an array object.
  		if(!IsKeyValid(key))
  		{
  			ErrorLevel = 1
  			return key
  		}
  		
  		; Append the key to watched keys
  		_WatchedKeys .= key
  	}
  }
}

RemoveWatchedKey(key)
{
  bkey := Brace(key)
  if(!IsKeyValid(bkey))
    return
  StringReplace, _WatchedKeys, _WatchedKeys, %bkey%,,All
}