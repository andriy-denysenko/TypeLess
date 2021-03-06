GetLanguageList()
{
  global
  list := ""
  langs := app.GetLanguageList()
  cur := app.Get("InterfaceLanguage")
  for lid, lname in langs
  {
    select := String_IsEqual(lid, cur)
    list := List_AddItem(list, lname, select)
  }
  return list
}
guiSettings := new CGui(app, "Settings", "+LabelGuiSettings", "CAP_Settings")

guiSettings.AddControl("Text"
  , "w200 vTxtInterfaceLanguage", "LBL_InterfaceLanguage")

guiSettings.AddControl("DropDownList"
  , "w200 vDdlInterfaceLanguage gDDL_InterfaceLanguage"
  , GetLanguageList(), "", 0, false)

guiSettings.AddControl("Checkbox"
  , "w200 vChkStartOnLogin gCHK_StartOnLogin" SetCheck("StartOnLogin")
  , "CHK_StartOnLogin")
  
guiSettings.AddControl("Checkbox"
  , "w200 vChkFilterOn gCHK_FilterOn" SetCheck("FilterOn")
  , "CHK_FilterOn")

guiSettings.AddControl("Groupbox"
  , "section w200 r3 vGrpEndChars"
  , "GRP_EndChars")
  
guiSettings.AddControl("Edit"
  , "ys+20 xs+10 w180 vEditEndChars gEditEndChars_OnChange","", "", 0, false)

guiSettings.AddControl("Checkbox"
  , "section vChkEnter gCHK_Enter_OnChange"
  , "CHK_Enter")
  
guiSettings.AddControl("Checkbox"
  , "ys vChkTab gCHK_Tab_OnChange"
  , "CHK_Tab")
  
guiSettings.AddControl("Checkbox"
  , "ys w75 vChkSpace gCHK_Space_OnChange"
  , "CHK_Space")

app.Forms["Settings"] := guiSettings
