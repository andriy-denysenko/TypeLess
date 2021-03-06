guiHsEditor := new CGui(app, "HsEditor", "+LabelHsEditor", "CAP_HsEditor")

guiHsEditor.AddControl("Text"
  , "w250 vTxtAbbreviation", "LBL_Abbreviation")
  
guiHsEditor.AddControl("Edit"
  , "w250 vEditAbbreviation gEditAbbreviation_OnChange","", "", 0, false)
  
guiHsEditor.AddControl("Text"
  , "w250 vTxtPhrase", "LBL_Phrase")
  
guiHsEditor.AddControl("Edit"
  , "w250 r5 vEditPhrase gEditPhrase_OnChange","", "", 0, false)
  
guiHsEditor.AddControl("Radio"
  , "w250 vChkCs"
  , "CHK_Cs") 

guiHsEditor.AddControl("Radio"
  , "w250 vChkCtc"
  , "CHK_Ctc")
  
guiHsEditor.AddControl("Checkbox"
  , "section y+10 w250 vChkRec gCHK_Rec_Change"
  , "CHK_Rec")
  
guiHsEditor.AddControl("Checkbox"
  , "w240 xs+10 vChkOec"
  , "CHK_Oec")
  
guiHsEditor.AddControl("Checkbox"
  , "w250 xm y+10 vChkRaw"
  , "CHK_Raw")
  
guiHsEditor.AddControl("Checkbox"
  , "w250 vChkDab"
  , "CHK_Dab")
  
guiHsEditor.AddControl("Checkbox"
  , "w250 vChkSa"
  , "CHK_Sa")
  
guiHsEditor.AddControl("Button"
  , "section y+20 w75 h25 Default vBtnHsEditorOk gHsEditorOk"
  , "BTN_OK")

guiHsEditor.AddControl("Button"
  , "ys w75 h25 vBtnHsEditorCancel gHsEditorCancel"
  , "BTN_Cancel")

app.Forms["HsEditor"] := guiHsEditor