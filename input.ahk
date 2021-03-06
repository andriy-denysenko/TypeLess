#include %A_ScriptDir%\watched-chars.ahk
global $EndChars := app.Get("EndChars")
AddWatchedChars($EndChars)

#include %A_ScriptDir%\valid-keys.ahk
#include %A_ScriptDir%\watched-keys.ahk
global $EndKeys := app.Get("EndKeys")
AddWatchedKeys($EndKeys)

#include %A_ScriptDir%\window.ahk
#include %A_ScriptDir%\caret.ahk
#include %A_ScriptDir%\input-filtering.ahk
#include %A_ScriptDir%\input-events.ahk
#include %A_ScriptDir%\input-handlers.ahk
#include %A_ScriptDir%\selection.ahk

global $SelectedWord := ""

;
; Function: IsEndChar
; Description:
;		Determines if a character is an ending character.
; Syntax: flag := IsEndChar(char)
; Parameters:
;		char - A character that is checked.
; Return Value:
; 	Returns true if a character is an ending character, or false otherwise.
; Related: IsWatchedChar
;
IsEndChar(char)
{
  if (InStr(app.Get("EndChars"), char) > 0)
    return true
  else
    return false
}

IsEndKey(key)
{
  if(InStr($EndKeys, key))
    return true
  else
    return false
}

AddEndKey(key)
{
  if(IsEndKey(key))
    return

  if(!$EndKeys)
  {
    $EndKeys := key
    return
  }
  $EndKeys .= "|" key
  AddWatchedKeys(key)
}

RemoveEndKey(key)
{
  if(!IsEndKey(key))
    return
  
  if(InStr($EndKeys, "|" key))
    StringReplace, $EndKeys, $EndKeys, |%key%,,All
  else if(InStr($EndKeys, key "|"))
    StringReplace, $EndKeys, $EndKeys, %key%|,,All
  else
    $EndKeys := ""
  
  RemoveWatchedKey(key)
}