#include <CHotKey>
tmp_failedHotkeys := ""
; TODO: check which value is written if no hotkey

if(!app.AddHotkeyCmd("CMD_AddHotstring", miAddHotstring))
  tmp_failedHotkeys .= app.Get("CMD_AddHotstring") "`n"
  
if(!app.AddHotkeyCmd("CMD_ListHotstrings", miListHotstrings))
  tmp_failedHotkeys .= app.Get("CMD_ListHotstrings") "`n"
  
if(!app.AddHotkeyCmd("CMD_ReplaceSelection"))
  tmp_failedHotkeys .= app.Get("CMD_ReplaceSelection") "`n"
  
if(!app.AddHotkeyCmd("CMD_FilterOn", miFilterOn))
  tmp_failedHotkeys .= app.Get("CMD_FilterOn") "`n"
  
if(!app.AddHotkeyCmd("CMD_ShowSettings", miSettings))
  tmp_failedHotkeys .= app.Get("CMD_ShowSettings") "`n"

if(tmp_failedHotkeys)
{
  msgbox, 48, % _t(app.ProductName), % _t("MSG_RegisterHkFailed") "`n" tmp_failedHotkeys "`n`n" _t("MSG_ModifyHKs")
}