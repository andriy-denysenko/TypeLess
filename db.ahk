#include <CHotstringOptions>
#include <CDataBase>
#include %A_ScriptDir%\db-handlers.ahk

dbFileName := app.get("CurrentFile")
if(!dbFileName)
{
  dbFileName := app.AppDataPath "\default.ini"
  app.Set("CurrentFile", dbFileName, true)
  AddRecent(dbFileName)
}
app.db := new CDataBase(dbFileName)

AddRecent(fileName)
{
  recent := app.Get("RecentFiles", true)
  if(recent = fileName)
    return
  
  if(recent = "")
  {
    recent := fileName
  }
  else if(!InStr(recent, "|"))
  {
    recent := fileName "|" recent
  }
  else
  {
    result := fileName
    Loop, Parse, recent, |
    {
      if(A_LoopField = fileName)
        continue
      if(A_LoopField <> _t("MI_NoRecent") && FileExist(A_LoopField) = "")
      {
        RemoveRecent(A_LoopField)
        continue
      }
      if(A_Index = 10)
        break
      result := result "|" A_LoopFIeld
    }
    recent := result
  }
  
  app.Set("RecentFiles", recent, true)
;   OutputDebug AddRecent: %recent%
  RefreshRecentMenu()
}

RemoveRecent(fileName)
{
;   OutputDebug RemoveRecent(%fileName%)
  recent := app.Get("RecentFiles", true)
  if(InStr(recent, "|" fileName))
    StringReplace, recent, recent, |%fileName%
  if(InStr(recent, fileName "|"))
    StringReplace, recent, recent, %fileName%|
  else if(recent = fileName)
    recent := ""
  app.Set("RecentFiles", recent, true)
}

RefreshRecentMenu()
{
  global
  RecentFiles := app.Get("RecentFiles", true)
;   OutputDebug recent %RecentFiles%
  mbRecent.RemoveItems()
  if(RecentFiles)
  {
    Loop, Parse, RecentFiles, |
    {
      mbRecent.AddLastItem(A_LoopField, "MI_Recent")
    }
  }
  else
  {
    mi := mbRecent.AddLastItem("MI_NoRecent", "MI_Recent")
    mi.enabled := false
  }
  mbRecent.Create()
}