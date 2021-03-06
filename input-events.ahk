; BeforeCharAppended
; AfterCharAppended
; OnWatchedChar
; OnBackspace
; OnWindowChanged
; OnCaretMoved
; OnWatchedKey
; BeforeBufferReset
; AfterBufferReset

TriggerInputEvent(event)
{
; 	OutputDebug, In TriggerInputEvent(%event%)

  $ResetRequired := true
	
	$CurrentWindow := WinExist("A")
;   OutputDebug `t$CurrentWindow = %$CurrentWindow%
	
	if(event = "Max")
	{
    $ResetRequired := false
    app.RaiseEvent("BeforeCharAppended")
    $Buffer .= $LastChar
;     OutputDebug Buffer: %$Buffer%
    app.RaiseEvent("AfterCharAppended")
    
	}
	else if(event = "Match")
	{
;     OutputDebug `tLastChar = %LastChar%
    app.RaiseEvent("OnWatchedChar")
	}
	else if (event = "EndKey")
	{
;     OutputDebug `tLastKey = %LastKey%
		if($LastKey = "BackSpace")
		{
      $ResetRequired := false
			BufferBackspace()
      app.RaiseEvent("OnBackspace")
; 			OutputDebug, % "Buffer: " Buffer
			
		}
    else if($LastKey = "Enter")
    {
      $LastChar := "`n" ; 1 BS should be sent
      app.RaiseEvent("OnEndKey")
    }
    else if($LastKey = "Tab")
    {
      $LastChar := "`t"
      app.RaiseEvent("OnEndKey")
    }
    else if($LastKey = "Space")
    {
      $LastChar := " "
      app.RaiseEvent("OnEndKey")
    }
		if(IsWindowChanged() = true)
		{
      app.RaiseEvent("OnWindowChanged")
		}
		else if(IsCaretMoved() = true)
		{
      app.RaiseEvent("OnCaretMoved")
		}
    app.RaiseEvent("OnWatchedKey")
	}
	else if (event = "MouseClick")
	{
		; To allow double-clicking, check the caret coordinates only if there is no the second click
		; (If the contents of these variables are fetched repeatedly at a high frequency (i.e. every 500 ms or faster), the user's ability to double-click will probably be disrupted. There is no known workaround.)
    
		if(IsWindowChanged() = true)
		{
      app.RaiseEvent("OnWindowChanged")
		}
    
    if($LastKey = "MButton")
      return
    
;     OutputDebug % "Cur win " WinExist("A")
    
    if(A_TimeSincePriorHotkey > 500)
    {
;       OutputDebug `tbefore setting timer`n`t`t$CurrentWindow = %$CurrentWindow%
      WinGetTitle, dbg_ActiveWindowTitle, ahk_id %$CurrentWindow%
;       OutputDebug `t`tTitle: %dbg_ActiveWindowTitle%
      SetTimer, CaretWaitingThread, -500
    }
		
    if(IsCaretMoved() = true)
		{
			app.RaiseEvent("OnCaretMoved")
		}
    
;     OutputDebug called OnCaretMoved
		
; 		app.RaiseEvent("MouseClick")
		
		$PreviousCaretX := $CurrentCaretX
		$PreviousCaretY := $CurrentCaretY

	}
	
	; Set Previous... properties
	$PreviousWindow := $CurrentWindow
	
	; Reset the buffer if the event does not add a character
	if($ResetRequired)
  {
;     OutputDebug Reset required
		Reset()
	}
;   OutputDebug `tBuffer = %Buffer%
  return
  
CaretWaitingThread:
;   OutputDebug % "Cur win " WinExist("A")
  ; A patch to avoid lost focus
  ; BUG: Unminimizes a window which was minimized with a mouse click 
;   WinActivate, ahk_id %$CurrentWindow%
;   OutputDebug CaretWaitingThread: Current window var value = %$CurrentWindow%
  SetTimer, CaretWaitingThread, off
  $CurrentCaretX := A_CaretX
	$CurrentCaretY := A_CaretY
;   OutputDebug CaretWaitingThread
;   OutputDebug % "Cur win " WinExist("A")
return
}

Reset()
{
  app.RaiseEvent("BeforeBufferReset")
;   OutputDebug Reset
  if($Buffer)
    $LastTypedWord := $Buffer
	$Buffer := ""
  app.db.Reset()
  app.RaiseEvent("AfterBufferReset")
}

BufferBackspace()
{
;   OutputDebug In BufferBackspace()
	if($Buffer <> "")
		StringTrimRight, $Buffer, $Buffer, 1
}