;
; Function: Contains
; Description:
;                Determines if the given string/object (haystack) contains the specified value (needle).
; Syntax: Position := Contains(haystack, needle)
; Parameters:
;                haystack - A string/object that may contain a needle.
;                needle - A value that may occur in haystack.
; Return Value:
;                Returns a 1-based index of the needle in the haystack. 0 means that the needle is not found in the haystack.
; Example:
;				haystackString := "abcdef"
;				haystackArray := ["ab", "cd", "ef"]
;				haystackAssocArray := {x1:"ab", x2:"cd", x3:"ef"}
;				needle1 := "cd"
;				needle2 := "dc"
;				MsgBox % "Position of '" needle1 "' in haystackString is 3:" Contains(haystackString, needle1)
;				MsgBox % "Position of '" needle2 "' in haystackString is 0:" Contains(haystackString, needle2)
;				MsgBox % "Index of '" needle1 "' in haystackArray is 2:" Contains(haystackArray, needle1)
;				MsgBox % "Index of '" needle2 "' in haystackArray is 0:" Contains(haystackArray, needle2)
;				MsgBox % "Key of '" needle1 "' in haystackAssocArray is x2:" Contains(haystackAssocArray, needle1)
;				MsgBox % "Key of '" needle2 "' in haystackAssocArray is 0:" Contains(haystackAssocArray, needle2)
;
Contains(haystack, needle)
{
	; If haystack is not an object, consider it a string
	if(!IsObject(haystack))
  {
    result := InStr(haystack, needle)
;     OutputDebug Contains: returning result %i%
    return
  }
	else
	{
		for i, v in haystack
		{
			if(v = needle)
      {
;         OutputDebug Contains: returning result %i%
        return i
      }
		}
;     OutputDebug Contains: returning false 
		return false
	}
}