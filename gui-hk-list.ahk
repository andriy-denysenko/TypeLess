guiHkList := new CGui(app, "HkList", "+LabelHkList", "CAP_HkList")

; ================================== Labels ====================================

guiHkList.AddControl("Text"
  , "section w175 vTxtHK_ShowSettings"
  , "HK_Settings")
  
guiHkList.AddControl("Text"
  , "w175 vTxtHK_FilterOn"
  , "HK_FilterOn")
  
guiHkList.AddControl("Text"
  , "w175 vTxtHK_ListHotstrings"
  , "HK_ListHotstrings")
  
guiHkList.AddControl("Text"
  , "w175 vTxtHK_AddHotstring"
  , "HK_AddHotstring")
  
guiHkList.AddControl("Text"
  , "w175 vTxtHK_ReplaceSelection"
  , "HK_ReplaceSelection")
  
; ============================= Hotkey controls ================================

; TODO: Add handlers to avoid duplicate hotkeys
guiHkList.AddControl("Hotkey"
  , "section ys-3 vHkeyHK_ShowSettings gHkey_Change"
  , "HK_Settings")
  
guiHkList.AddControl("Hotkey"
  , "vHkeyHK_FilterOn gHkey_Change"
  , "HK_FilterOn")
  
guiHkList.AddControl("Hotkey"
  , "vHkeyHK_ListHotstrings gHkey_Change"
  , "HK_ListHotstrings")
  
guiHkList.AddControl("Hotkey"
  , "vHkeyHK_AddHotstring gHkey_Change"
  , "HK_AddHotstring")
  
guiHkList.AddControl("Hotkey"
  , "vHkeyHK_ReplaceSelection gHkey_Change"
  , "HK_ReplaceSelection")
  
; ================================= Buttons ====================================
  
guiHkList.AddControl("Button"
  , "section xm w75 h25 Default vBtnHkListOk gBtnHkListOk_Click"
  , "BTN_OK")
  
guiHkList.AddControl("Button"
  , "ys w75 h25 vBtnHkListCancel gBtnHkListCancel_Click"
  , "BTN_Cancel")
  
app.Forms["HkList"] := guiHkList