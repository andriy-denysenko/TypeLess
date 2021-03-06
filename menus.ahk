#include <CMenuBar>

tray := new CMenuBar()
mbFile := new CMenuBar("MB_File", tray)
mbFile.AddLastItem("MI_New", "MI_New")
mbFile.AddLastItem("MI_Open", "MI_Open")
mbFile.AddLastItem()
mbRecent := new CMenuBar("MB_Recent", mbFile)
RecentFiles := app.Get("RecentFiles")
if(RecentFiles)
{
  Loop, Parse, RecentFiles, |
    mbRecent.AddLastItem(A_LoopField, "MI_Recent")
}
else
{
  mi := mbRecent.AddLastItem("MI_NoRecent", "MI_Recent")
  mi.enabled := false
}
miSettings := tray.AddLastItem("MI_Settings", "MI_Settings")
miHkList := tray.AddLastItem("MI_HkList", "MI_HkList")
tray.AddLastItem()
miFilterOn := tray.AddLastItem("MI_FilterOn", "MI_FilterOn")
tray.AddLastItem()
miAddHotstring := tray.AddLastItem("MI_AddHotstring", "MI_AddHotstring")
miListHotstrings := tray.AddLastItem("MI_ListHotstrings", "MI_ListHotstrings")
tray.AddLastItem()
tray.AddLastItem("MI_About", "MI_About")
tray.AddLastItem()
tray.AddLastItem("MI_Exit", "MI_Exit")
app.menus["tray"] := tray

g_filterOn := app.Get("FilterOn")

if(g_filterOn)
  miFilterOn.checked := true
else
  miFilterOn.checked := false
