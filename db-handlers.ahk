app.Subscribe(Func("MatchesFound"), "MatchesFound")
app.Subscribe(Func("MatchesNotFound"), "MatchesNotFound")

MatchesFound()
{
;   OutputDebug In MatchesFound()
  if(!IsEmpty(app.db.result.foundHs))
  {
    $FormattedPhrase := FormatHotstringPhrase(app.db.result.foundHs)
    if(!app.db.result.foundHs.RequireEndChar)
    {
      SendWithoutEndChar()
      $ResetRequired := true
    }
    else
    {
      ShowToolTip($FormattedPhrase)
    }
  }
}

MatchesNotFound()
{
  HideToolTip()
  $FormattedPhrase := ""
}