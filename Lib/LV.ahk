LV_ChooseString(needle, col = 1)
{
;   OutputDebug LV_ChooseString(%needle%, %col%)
  cnt := LV_GetCount()
  Loop, %cnt%
  {
    LV_GetText(txt, A_Index, col)
    if(txt = needle)
    {
;       OutputDebug Index = %A_Index%
      return A_Index
      break
    }
  }
;   OutputDebug Index = 0
  return 0
}