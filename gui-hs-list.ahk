guiHsList := new CGui(app, "HsList", "+LabelHsList", "CAP_HsList")

guiHsList.AddControl("Groupbox"
  , "section w400 r9 vGrpHotstrings"
  , "GRP_Hotstrings")

guiHsList.AddControl("ListView"
  , "xs+10 ys+20 w380 r10 Grid -Multi AltSubmit vLvHsList gLvHsList_Event"
  , "LBL_Abbreviation|LBL_Phrase")
  
guiHsList.AddControl("Button"
  , "section xm w75 h25 vBtnHsListAdd gBtnHsListAdd_Click"
  , "BTN_AddHotstring")
  
guiHsList.AddControl("Button"
  , "ys w75 h25 vBtnHsListEdit gBtnHsListEdit_Click"
  , "BTN_EditHotstring")
  
guiHsList.AddControl("Button"
  , "ys w75 h25 vBtnHsListRemove gBtnHsListRemove_Click"
  , "BTN_RemoveHotstring")

app.Forms["HsList"] := guiHsList

global _SortAscending1 := true
global _SortAscending2 := true
global _SortColumn := 1
global _PrevColumn := 1