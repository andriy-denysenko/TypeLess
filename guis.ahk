#include <CGui>

SetCheck(param)
{
  global
  if(app.Get(param))
    return " Checked"
  else
    return ""
}

#include %A_ScriptDir%\gui-settings.ahk
#include %A_ScriptDir%\gui-hs-edit.ahk
#include %A_ScriptDir%\gui-hs-list.ahk
#include %A_ScriptDir%\gui-hk-list.ahk