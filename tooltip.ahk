ShowToolTip(text)
{
  ; TODO: adjust tooltip x & y
  x := A_CaretX
  y := A_CaretY - 20
  ToolTip,%text%,%x%,%y%,1
}

HideToolTip()
{
  ToolTip,,,,1
}