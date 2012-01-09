global $FormattedPhrase := ""

SendOnEndChar()
{
;   OutputDebug in SendOnEndChar()
  if(app.db.result.foundHs.DeleteHotstring)
  {
    DeleteInput(StrLen(app.db.result.foundHs.Abbreviation) + StrLen($LastChar))
  }

;   OutputDebug `tSending %$FormattedPhrase%
  
  SendPhrase()
    
  if(!app.db.result.foundHs.OmitEndChar)
    Send, %$LastChar%
  
  $FormattedPhrase := ""
}

SendWithoutEndChar()
{
  if(app.db.result.foundHs.DeleteHotstring)
  {
    DeleteInput(StrLen(app.db.result.foundHs.Abbreviation))
  }

  SendPhrase()
  $FormattedPhrase := ""
}

SendPhrase()
{
  if(app.db.result.foundHs.Raw)
    SendRaw, %$FormattedPhrase%
  else
  {
    StringReplace, $FormattedPhrase, $FormattedPhrase, ^, {^}, All
    StringReplace, $FormattedPhrase, $FormattedPhrase, !, {!}, All
    StringReplace, $FormattedPhrase, $FormattedPhrase, +, {+}, All
    StringReplace, $FormattedPhrase, $FormattedPhrase, #, {#}, All
    StringReplace, $FormattedPhrase, $FormattedPhrase, {, {{}, All
    StringReplace, $FormattedPhrase, $FormattedPhrase, }, {}}, All
    
    $FormattedPhrase := RegExReplace($FormattedPhrase, "i)\[(Left|Right|Up|Down)([\s\d]*)\]", "{${1}${2}}")
    
    if(InStr($FormattedPhrase, "[TimeDate]"))
    {
      FormatTime, time, %A_Now%
      StringReplace, $FormattedPhrase, $FormattedPhrase, [TimeDate], %time%, All
    }
    if(InStr($FormattedPhrase, "[Time]"))
    {
      FormatTime, time, %A_Now%, Time
      StringReplace, $FormattedPhrase, $FormattedPhrase, [Time], %time%, All
    }
    if(InStr($FormattedPhrase, "[ShortDate]"))
    {
      FormatTime, time, %A_Now%, ShortDate
      StringReplace, $FormattedPhrase, $FormattedPhrase, [ShortDate], %time%, All
    }
    if(InStr($FormattedPhrase, "[LongDate]"))
    {
      FormatTime, time, %A_Now%, LongDate
      StringReplace, $FormattedPhrase, $FormattedPhrase, [LongDate], %time%, All
    }
    if(InStr($FormattedPhrase, "[YearMonth]"))
    {
      FormatTime, time, %A_Now%, YearMonth
      StringReplace, $FormattedPhrase, $FormattedPhrase, [YearMonth], %time%, All
    }
    
    Send, %$FormattedPhrase%
  }
}

DeleteInput(len)
{
;   OutputDebug Deleting %len% characters
  if(len)
    Send, {BS %len%}
}

GetFormatPattern(hs)
{
  global
  local pattern := $Buffer
	if(hs.StartAnywhere = true)
	{
		local len := StrLen(hs.abbrKey)
		StringRight, pattern, pattern, %len%
	}
  return pattern
}

FormatHotstringPhrase(hs)
{
  global
  local pattern := GetFormatPattern(hs)
  local formattedPhrase := hs.Phrase
  if(hs.ConformToTypedCase = true)
  {
    formattedPhrase := String_CopyFormat(pattern, hs.Phrase)
  }
  
  return formattedPhrase
}