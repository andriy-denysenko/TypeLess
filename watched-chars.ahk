; These characters are used as MatchList parameter for the Input command.
; Some of them may be used as ending characters for phrase insertion, others may reset the hotstring recognizer.
; Default watched characters are default AutoHotkey ending characters not including Enter, Tab & Space (which are used as ending keys).
; @DEF_WATCHED_CHARS should be treated as a constant that is used to initialize _WatchedChars as well as to reset settings.
global _DEF_WATCHED_CHARS := ",,,-,_,(,),[,],{,},:,;,',"",/,\,.,!,?"
global _WatchedChars := _DEF_WATCHED_CHARS

;
; Function: IsWatchedChar
; Description:
;		Determines if a character is watched.
; Syntax: flag := IsWatchedChar(char)
; Parameters:
;		char - A character that is checked.
; Return Value:
; 	Returns true if a character is a watched character, or false otherwise.
; Related: AddWatchedChars
;
IsWatchedChar(char)
{
  global _WatchedChars
  if char in % _WatchedChars
    return true
  else
    return false
}

;
; Function: AddWatchedChars
; Description:
;		Adds characters to be watched by the filter.
; Syntax: AddWatchedChars(strChars)
; Parameters:
;		strChars - A string containing characters to be watched
; Related: AddWatchedKeys
; Example:
;		AddWatchedChars(",:;-.!?()/\{}")
;
AddWatchedChars(newChars)
{
  global _WatchedChars
	; Loop through chars one at a time
	Loop, Parse, newChars
	{
		; Move to the next char if the current char is already watched
		if(IsWatchedChar(A_LoopField))
			continue
		
		; If the current char is comma, put it at the beginning of the string (see the comment for WatchedChars variable for explanation)
		if(A_LoopField = ",")
			_WatchedChars := ",,," _WatchedChars
		else
		{
			; If there are no watched chars, this one will be the 1st
			if(_WatchedChars = "")
				_WatchedChars := A_LoopField
			else
				; Append the current char after the last watched char separated by comma
				_WatchedChars .= "," A_LoopField ; Don't place a space after comma because spaces are significant
		}
	} ; End parsing loop
}

GetWatchedChars()
{
  global _WatchedChars
  result := ""
  if(InStr(_WatchedChars, ",,,"))
    result := ","
  tail := _WatchedChars
  StringReplace, tail, tail, `,,,All
  result .= tail
  return result
}