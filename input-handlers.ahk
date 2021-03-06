; Events:
;
; BeforeCharAppended
; AfterCharAppended
; OnWatchedChar
; OnBackspace
; OnWindowChanged
; OnCaretMoved
; OnWatchedKey
; BeforeBufferReset
; AfterBufferReset

; app.Subscribe(Func("BeforeCharAppended"), "BeforeCharAppended")
app.Subscribe(Func("AfterCharAppended"), "AfterCharAppended")
app.Subscribe(Func("OnWatchedChar"), "OnWatchedChar")
app.Subscribe(Func("OnBackspace"), "OnBackspace")
; The following events are not needed because reset is done for each event except for ...CharAppended & BackSpace
; app.Subscribe(Func("OnWindowChanged"), "OnWindowChanged")
; app.Subscribe(Func("OnCaretMoved"), "OnCaretMoved")
app.Subscribe(Func("OnEndKey"), "OnEndKey")

; app.Subscribe(Func("BeforeBufferReset"), "BeforeBufferReset")
app.Subscribe(Func("AfterBufferReset"), "AfterBufferReset")

AfterCharAppended()
{
;   OutputDebug AfterCharAppended()
  if(IsObject(app.db.findAll($Buffer)))
    app.RaiseEvent("MatchesFound")
  else
    app.RaiseEvent("MatchesNotFound")
}

OnWatchedChar()
{
  if(IsEndChar($LastChar) && IsObject(app.db.result))
	{
    SendOnEndChar()
	}
}

OnEndKey()
{
  if(IsObject(app.db.result))
  {
;     OutputDebug DB Result in OnEndKey
;     dump(app.db.result)
    SendOnEndChar()
  }
}

OnBackspace()
{
  ; Imitate the previous character pressing
  if($Buffer)
  {
    $LastChar := SubStr($Buffer, 0, 1)
  }
  else
  {
    $LastChar := ""
  }
  $LastKey := ""
  AfterCharAppended()
}

AfterBufferReset()
{
  HideToolTip()
  $FormattedPhrase := ""
}