global $StringCaseSense := A_StringCaseSense
String_CaseSense_Remember()
{
  $StringCaseSense := A_StringCaseSense
}

String_CaseSense_Restore()
{
  StringCaseSense, %$StringCaseSense% 
}