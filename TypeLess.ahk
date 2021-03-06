; Make the script persistent if no gui is created
#Persistent
; Allow single instance only
#SingleInstance, Force

; Set AutoHotkey settings
AutoTrim, off
SetKeyDelay, 0
FileEncoding, UTF-16

; Include classes

; Include KeyboardLayout functions (this is for convenience because these functions are included when called.)
#include <KeyboardLayout>

#include <LV>

; Include the application class
#include <CApplication>
global app := new CApplication()


_t(strId)
{
  global
  return app.GetString(strId)
}
; Start including files from A_ScriptDir
; Process command-line parameters
#include %A_ScriptDir%\command-line.ahk
; Command-line parameters are processed, -x parameter was absent

; Include string-processing functions
#include %A_ScriptDir%\string.ahk

; Configure the application
#include %A_ScriptDir%\config.ahk

; Configure db
#include %A_ScriptDir%\db.ahk

; Configure menus
#include %A_ScriptDir%\menus.ahk

; Configure hotkeys
#include %A_ScriptDir%\hotkeys.ahk

; Configure GUIs
#include %A_ScriptDir%\guis.ahk

; Include tooltip functions
#include %A_ScriptDir%\tooltip.ahk

; Configure user input
#include %A_ScriptDir%\input.ahk

; Configure output
#include %A_ScriptDir%\output.ahk



; Start the application
app.Run()

if(app.Get("FilterOn") = true)
  StartInputFiltering()

; OutputDebug, =============== TypeLess End ====================

return

MI_About:
  msgbox,0, % _t("MI_About"), % app.ProductName " " app.ProductVersion "`n(c) Andriy Denysenko 2011`ndenysenko.andriy@gmail.com"

return

MI_Exit:
  app.Exit()
return

MI_Recent:
  app.Set("CurrentFile", A_ThisMenuItem, true)
  AddRecent(A_ThisMenuItem)
  app.db := new CDataBase(A_ThisMenuItem)
  if(app.Forms["HsList"].visible)
    gosub HsList_Refresh
return

MI_New:
  fileName := app.Get("CurrentFile")
  SplitPath, fileName, , dir
  FileSelectFile, fileName, 16, %dir%, % _t("MSG_NewFile"), % _t("INI file") " (*.ini)"
  if ErrorLevel
    return
  
  if(SubStr(fileName, -3) <> ".ini")
    fileName .= ".ini"
  app.Set("CurrentFile", fileName)
  AddRecent(fileName)
  app.db := new CDataBase(fileName)
  if(app.Forms["HsList"].visible)
    gosub HsList_Refresh
return

MI_Open:
  fileName := app.Get("CurrentFile")
  SplitPath, fileName, , dir
  FileSelectFile, fileName, 3, %dir%, % _t("MSG_OpenFile"), % _t("INI file") " (*.ini)"
  if ErrorLevel
    return
  
  app.Set("CurrentFile", fileName)
  AddRecent(fileName)
  app.db := new CDataBase(fileName)
  if(app.Forms["HsList"].visible)
    gosub HsList_Refresh
  ; TODO: check if the file is a valid ini file
return

GuiSettingsEscape:
  app.Forms["Settings"].Hide()
return

; ============================= CHK_StartOnLogin ===============================

CHK_StartOnLogin:
  g_startOnLogin := app.Get("StartOnLogin")
  if(g_startOnLogin)
  {
    app.StoreSetting("StartOnLogin", false)
    FS_StartupShortcutRemove(A_ScriptFullPath)
  }
  else
  {
    app.StoreSetting("StartOnLogin", true)
    FS_StartupShortcutCreate(A_ScriptFullPath)
  }
return

; ================================= FilterOn ===================================

CHK_FilterOn:
  g_FilterOn := app.Get("FilterOn")
  if(g_FilterOn)
  {
    app.StoreSetting("FilterOn", false)
    app.menus["tray"].itemsByNames["MI_FilterOn"].Uncheck()
    StopInputFiltering()
  }
  else
  {
    app.StoreSetting("FilterOn", true)
    app.menus["tray"].itemsByNames["MI_FilterOn"].Check()
    StartInputFiltering()
  }  
return

MI_FilterOn:
CMD_FilterOn:
  g_FilterOn := app.Get("FilterOn")
  if(g_FilterOn)
  {
    app.StoreSetting("FilterOn", false)
    app.menus["tray"].itemsByNames["MI_FilterOn"].Uncheck()
    app.Forms["Settings"].controlsByNames["ChkFilterOn"].SetValue(false)
    StopInputFiltering()
  }
  else
  {
    app.StoreSetting("FilterOn", true)
    app.menus["tray"].itemsByNames["MI_FilterOn"].Check()
    app.Forms["Settings"].controlsByNames["ChkFilterOn"].SetValue(true)
    ; Do not call StartInputFiltering() directly or the hotkey subroutine will not finish until StopInputFiltering() preventing the hotkey from being called
    SetTimer, CMD_FilterOn_Start, 100
  }
return

CMD_FilterOn_Start:
  SetTimer, CMD_FilterOn_Start, Off
  StartInputFiltering()
return

; =============================== Settings GUI =================================

global $EditEndChars_OnChangeCancel := false

CMD_ShowSettings:
MI_Settings:
  app.Forms["Settings"].controlsByNames["DdlInterfaceLanguage"].SetValue(GetLanguageList())
  $EditEndChars_OnChangeCancel := true
  app.Forms["Settings"].controlsByNames["EditEndChars"].SetValue($EndChars)
  app.Forms["Settings"].controlsByNames["ChkEnter"].SetValue(IsEndKey("Enter"))
  app.Forms["Settings"].controlsByNames["ChkTab"].SetValue(IsEndKey("Tab"))
  app.Forms["Settings"].controlsByNames["ChkSpace"].SetValue(IsEndKey("Space"))
  app.Forms["Settings"].Show()
return

EditEndChars_OnChange:
  if($EditEndChars_OnChangeCancel)
  {
    $EditEndChars_OnChangeCancel := false
    return
  }

  $EditEndChars_OnChangeCancel := false
  $EndChars := app.Forms["Settings"].controlsByNames["EditEndChars"].GetValue() 
  StringReplace, $EndChars, $EndChars, %A_Space%,,All
  _WatchedChars := ""
  AddWatchedChars($EndChars)
  $EndChars := GetWatchedChars()
  app.Set("EndChars", $EndChars, true)
  app.Forms["Settings"].controlsByNames["EditEndChars"].SetValue($EndChars)
return

CHK_Enter_OnChange:
  val := app.Forms["Settings"].controlsByNames["ChkEnter"].GetValue()
  if(val)
    AddEndKey("Enter")
  else
    RemoveEndKey("Enter")
;   OutputDebug $EndKeys = %$EndKeys%
  app.Set("EndKeys", $EndKeys, true)
return

CHK_Tab_OnChange:
  val := app.Forms["Settings"].controlsByNames["ChkTab"].GetValue()
  if(val)
    AddEndKey("Tab")
  else
    RemoveEndKey("Tab")
;   OutputDebug $EndKeys = %$EndKeys%
  app.Set("EndKeys", $EndKeys, true)
return

CHK_Space_OnChange:
  val := app.Forms["Settings"].controlsByNames["ChkSpace"].GetValue()
  if(val)
    AddEndKey("Space")
  else
    RemoveEndKey("Space")
;   OutputDebug $EndKeys = %$EndKeys%
  app.Set("EndKeys", $EndKeys, true)
return

; ============================ DDL_InterfaceLanguage ===========================

DDL_InterfaceLanguage:
  langName := app.Forms["Settings"].controlsByNames["DdlInterfaceLanguage"].GetValue()
;   OutputDebug Lang set to %langName%
  langId := app.loc.GetLangIdByName(langName)
;   OutputDebug Has id %langId%
  app.Localize(langId)
return

; ================================= HsEditor ===================================

global EditPhrase_OnChangeCancel := false
global EditAbbreviation_OnChange := false
; TODO: add CMD_AddLastTypedWord hotkey [and menu item]
CMD_AddLastTypedWord:
  word := $Buffer
  if(!word)
    word := $LastTypedWord
  if(!word)
    return
  
  $SelectedWord := word
  goto CMD_AddHotstring
return

CMD_AddHotstring:
MI_AddHotstring:
  if($SelectedWord = "____New")
    $SelectedWord =
  else
  {
    if(!$SelectedWord)
      $SelectedWord := CopySelection()
    if(!$SelectedWord)
      $SelectedWord := Clipboard
  }
  EditPhrase_OnChangeCancel := true
  ; TODO: the form title must be Add for adding and Edit for editing
  ; TODO: INTO DOCS - a user can add only if no selection in the fg window/HS list 
  hkl := KeyboardLayout_Get()
  
  if(app.Forms["HsList"].visible)
  {
    app.Forms["HsEditor"].AddOption("OwnerHsList")
    app.Forms["HsEditor"].Show(true)
  }
  else
  {
    app.Forms["HsEditor"].RemoveOption("OwnerHsList")
    app.Forms["HsEditor"].Show()
  }
  
  hs := app.db.GetPhraseHotstring($SelectedWord)
  abbrHs := app.db.HasAbbreviation($SelectedWord)
;   OutputDebug % "hs.Abbreviation = " hs.Abbreviation
  if(abbrHs <> false)
    hs := abbrHs
  if(hs)
  {
    ; EDITING MODE
    app.Forms["HsEditor"].controlsByNames["EditAbbreviation"].SetValue(hs.Abbreviation)
    app.Forms["HsEditor"].controlsByNames["EditPhrase"].SetValue(hs.Phrase)
    app.Forms["HsEditor"].controlsByNames["ChkCs"].SetValue(hs.CaseSensitive)
    app.Forms["HsEditor"].controlsByNames["ChkCtc"].SetValue(hs.ConformToTypedCase)
    app.Forms["HsEditor"].controlsByNames["ChkRec"].SetValue(hs.RequireEndChar)
    if(hs.RequireEndChar)
    {
      app.Forms["HsEditor"].controlsByNames["ChkOec"].Enable()
      app.Forms["HsEditor"].controlsByNames["ChkOec"].SetValue(hs.OmitEndChar)
    }
    else
    {
      app.Forms["HsEditor"].controlsByNames["ChkOec"].Disable()
      app.Forms["HsEditor"].controlsByNames["ChkOec"].SetValue(false)
    }
    app.Forms["HsEditor"].controlsByNames["ChkRaw"].SetValue(hs.Raw)
    app.Forms["HsEditor"].controlsByNames["ChkDab"].SetValue(hs.DeleteHotstring)
    app.Forms["HsEditor"].controlsByNames["ChkSa"].SetValue(hs.StartAnywhere)
    app.Forms["HsEditor"].controlsByNames["BtnHsEditorOk"].Enable()
    app.Forms["HsEditor"].hs := hs
    app.Forms["HsEditor"].mode := "EDIT"
  }
  else
  {
    ; ADDING MODE
    app.Forms["HsEditor"].controlsByNames["EditAbbreviation"].SetValue("")
    app.Forms["HsEditor"].controlsByNames["EditPhrase"].SetValue($SelectedWord)
    app.Forms["HsEditor"].controlsByNames["ChkCs"].SetValue(CHotstringOptions.DefaultOptions.CaseSensitive)
    app.Forms["HsEditor"].controlsByNames["ChkCtc"].SetValue(CHotstringOptions.DefaultOptions.ConformToTypedCase)
    app.Forms["HsEditor"].controlsByNames["ChkRec"].SetValue(CHotstringOptions.DefaultOptions.RequireEndChar)
    if(CHotstringOptions.DefaultOptions.RequireEndChar)
    {
      app.Forms["HsEditor"].controlsByNames["ChkOec"].Enable()
      app.Forms["HsEditor"].controlsByNames["ChkOec"].SetValue(CHotstringOptions.DefaultOptions.OmitEndChar)
    }
    else
    {
      app.Forms["HsEditor"].controlsByNames["ChkOec"].Disable()
      app.Forms["HsEditor"].controlsByNames["ChkOec"].SetValue(false)
    }
    
    app.Forms["HsEditor"].controlsByNames["ChkRaw"].SetValue(CHotstringOptions.DefaultOptions.Raw)
    app.Forms["HsEditor"].controlsByNames["ChkDab"].SetValue(CHotstringOptions.DefaultOptions.DeleteHotstring)
    app.Forms["HsEditor"].controlsByNames["ChkSa"].SetValue(CHotstringOptions.DefaultOptions.StartAnywhere)
    app.Forms["HsEditor"].hs := CHotstringOptions.DefaultOptions
    app.Forms["HsEditor"].hs.Phrase := $SelectedWord
    app.Forms["HsEditor"].hs.Abbreviation := ""
    app.Forms["HsEditor"].controlsByNames["BtnHsEditorOk"].Disable()
    app.Forms["HsEditor"].mode := "ADD"
  }
  
  KeyboardLayout_Set(hkl)
  app.Forms["HsEditor"].controlsByNames["EditAbbreviation"].Focus()
  $SelectedWord := ""
return

EditAbbreviation_OnChange:
  if(EditAbbreviation_OnChangeCancel)
  {
    EditAbbreviation_OnChangeCancel := false
    return
  }
  abbr := app.Forms["HsEditor"].controlsByNames["EditAbbreviation"].GetValue()
;   OutputDebug Typed abbr %abbr%
  StringCaseSense, On
  existingHs := app.db.HasAbbreviation(abbr)
  if(existingHs && existingHs.Abbreviation <> app.Forms["HsEditor"].hs.Abbreviation)
  {
    app.Forms["HsEditor"].controlsByNames["BtnHsEditorOk"].Disable()
    app.Forms["HsEditor"].controlsByNames["EditAbbreviation"].Font("cRed")
;     OutputDebug Has Abbr
  }
  else
  {
    app.Forms["HsEditor"].controlsByNames["BtnHsEditorOk"].Enable()
    app.Forms["HsEditor"].controlsByNames["EditAbbreviation"].Font()
;     OutputDebug No Abbr
  }
  StringCaseSense, Off
  EditAbbreviation_OnChangeCancel := false
  
return

EditPhrase_OnChange:
  if(EditPhrase_OnChangeCancel)
  {
    EditPhrase_OnChangeCancel := false
    return
  }
  phrase := app.Forms["HsEditor"].controlsByNames["EditPhrase"].GetValue()
  hs := app.db.GetPhraseHotstring(phrase)
  if(hs)
  {
;     app.Forms["HsEditor"].controlsByNames["BtnHsEditorOk"].Disable()
    app.Forms["HsEditor"].controlsByNames["EditPhrase"].Font("cMaroon")
  }
  else
  {
;     app.Forms["HsEditor"].controlsByNames["BtnHsEditorOk"].Enable()
    app.Forms["HsEditor"].controlsByNames["EditPhrase"].Font()
  }
  EditPhrase_OnChangeCancel := false
  
return

CHK_Rec_Change:
  val := app.Forms["HsEditor"].controlsByNames["ChkRec"].GetValue()
  if(val)
    app.Forms["HsEditor"].controlsByNames["ChkOec"].Enable()
  else
  {
    app.Forms["HsEditor"].controlsByNames["ChkOec"].SetValue(false)
    app.Forms["HsEditor"].controlsByNames["ChkOec"].Disable()
  }
return

HsEditorOk:
  if(app.Forms["HsEditor"].mode = "EDIT")
  {
    if(app.db.RemoveHotstring(app.Forms["HsEditor"].hs.Abbreviation))
    {
      app.Forms["HsList"].Default()
      selIndex := LV_GetNext()
;       OutputDebug selIndex %selIndex%
      if(selIndex)
        LV_Delete(selIndex)
    }
  }
  app.Forms["HsEditor"].Default()
  hs := {}
  hs.Abbreviation := app.Forms["HsEditor"].controlsByNames["EditAbbreviation"].GetValue()
  hs.Phrase := app.Forms["HsEditor"].controlsByNames["EditPhrase"].GetValue()
  hs.CaseSensitive:= app.Forms["HsEditor"].controlsByNames["ChkCs"].GetValue()
  hs.ConformToTypedCase := app.Forms["HsEditor"].controlsByNames["ChkCtc"].GetValue()
  hs.RequireEndChar := app.Forms["HsEditor"].controlsByNames["ChkRec"].GetValue()
  hs.OmitEndChar := app.Forms["HsEditor"].controlsByNames["ChkOec"].GetValue()
  hs.Raw := app.Forms["HsEditor"].controlsByNames["ChkRaw"].GetValue()
  hs.DeleteHotstring := app.Forms["HsEditor"].controlsByNames["ChkDab"].GetValue()
  hs.StartAnywhere := app.Forms["HsEditor"].controlsByNames["ChkSa"].GetValue()
  
  if(!app.db.AddHotstring(hs, true))
  {
    msgbox, 48, % _t("CAP_HsEditor"), % _t("MSG_CouldNotEditAbbr")
    if(!app.db.AddHotstring(app.Forms["HsEditor"].hs, true))
    {
      msgbox, 48, % _t("CAP_HsEditor"), % _t("MSG_CouldNotRestoreAbbr")
    }
  }
  else
  {
    app.Forms["HsList"].Default()
    LV_Add("Select", hs.Abbreviation, hs.Phrase)
    
;     OutputDebug _SortColumn = %_SortColumn%
;     OutputDebug % "_SortAscending = " _SortAscending%_SortColumn%
    
    if(_SortAscending%_SortColumn%)
      LV_ModifyCol(_SortColumn, "Sort Case")
    else
      LV_ModifyCol(_SortColumn, "SortDesc Case")
    
    index := LV_ChooseString(hs.Abbreviation)
    LV_Modify(index, "Vis")
    
  }
  app.Forms["HsEditor"].hide()
  
return

HsEditorCancel:
HsEditorEscape:
HsEditorClose:
  app.Forms["HsEditor"].hs := ""
  app.Forms["HsEditor"].Hide()
return

; ================================== HsList ====================================

CMD_ListHotstrings:
MI_ListHotstrings:
  sel := CopySelection()
  app.Forms["HsList"].Show()
  gosub HsList_Refresh

  LV_ModifyCol(1, "Sort Case")
  
;   OutputDebug Selection = %sel%
  index := LV_ChooseString(sel)
  if(!index)
  {
    index := LV_ChooseString(sel, 2)
  }
  if(index)
  {
    LV_Modify(index, "Vis Select")
  }
return

HsList_Refresh:
  app.Forms["HsList"].Default()
  selIndex := LV_GetNext()
  if(!selIndex)
    selIndex = 1
  GuiControl, -Redraw, LvHsList
  LV_Delete()
  
  for key, hs in app.db.data.hotstrings
  {
;     OutputDebug Adding hs %key%
    LV_Add("", hs.Abbreviation, hs.Phrase)
  }
  GuiControl, +Redraw, LvHsList
  
  if(LV_GetCount())
  {
    LV_Modify(selIndex, "Select")
    LV_Modify(selIndex, "Vis")

  }
return

LvHsList_Event:
;   OutputDebug LvHsList_Event
  app.Forms["HsList"].Default()
  index := LV_GetNext()
  if(A_GuiEvent = "ColClick")
  {
    _SortColumn := A_EventInfo
    if(_SortColumn = _PrevColumn)
      _SortAscending%_SortColumn% := !_SortAscending%_SortColumn%
    if(_SortAscending%_SortColumn%)
      LV_ModifyCol(_SortColumn, "Sort Case")
    else
      LV_ModifyCol(_SortColumn, "SortDesc Case")
    _PrevColumn := _SortColumn
    LV_Modify(index, "Vis")
  }
  if(A_GuiEvent = "DoubleClick")
  {
    gosub BtnHsListEdit_Click
  }
;   OutputDebug sel?
  
  if(index > 0)
  {
;     OutputDebug sel
    app.Forms["HsList"].controlsByNames["BtnHsListAdd"].Enable()
    app.Forms["HsList"].controlsByNames["BtnHsListEdit"].Enable()
    app.Forms["HsList"].controlsByNames["BtnHsListRemove"].Enable()
  }
  else
  {
;     OutputDebug not sel
    app.Forms["HsList"].controlsByNames["BtnHsListAdd"].Enable()
    app.Forms["HsList"].controlsByNames["BtnHsListEdit"].Disable()
    app.Forms["HsList"].controlsByNames["BtnHsListRemove"].Disable()
  }
return

BtnHsListAdd_Click:
  $SelectedWord := "____New"
  gosub CMD_AddHotstring
return

BtnHsListEdit_Click:
  app.Forms["HsList"].Default()
  selIndex := LV_GetNext()
  if(!selIndex)
    return
  LV_GetText(abbr, selIndex, 1)
  $SelectedWord := abbr
  gosub CMD_AddHotstring
return

BtnHsListRemove_Click:
  selIndex := LV_GetNext()
  if(!selIndex)
    return
  LV_GetText(abbr, selIndex)
  msgbox, 36, % app.ProductName, % _t("MSG_ConfirmRemoveAbbr") abbr "?"
  ifMsgBox, No
    return
  
  app.db.RemoveHotstring(abbr)
  app.Forms["HsList"].Default()
  selIndex := LV_GetNext()
;       OutputDebug selIndex %selIndex%
  if(selIndex)
    LV_Delete(selIndex)

return

HsListEscape:
HsListCancel:
HsListClose:
  app.Forms["HsList"].Hide()
return

; ============================= ReplaceSelection ===============================

CMD_ReplaceSelection:
  $Buffer := CopySelection()
  if(!IsObject(app.db.findAll($Buffer)))
    return
  if(!IsEmpty(app.db.result.foundHs))
  {
    $FormattedPhrase := FormatHotstringPhrase(app.db.result.foundHs)
    SendPhrase()
    $ResetRequired := true
    
  }
return

; =============================== Hotkey list ==================================

MI_HkList:
  tmp_HotkeysDisabled := app.DisableHotkeys()
;   if(!tmp_HotkeysDisabled)
;     OutputDebug Could not disable some hotkeys
  app.ShowForm("HkList", "A")
  for strHk, hk in app.hotkeys
  {
    tmp_HotkeyControlVar := hk.label
    StringReplace, tmp_HotkeyControlVar, tmp_HotkeyControlVar, CMD_, HkeyHK_
    app.Forms["HkList"].controlsByNames[tmp_HotkeyControlVar].SetValue(strHk)
  }
  app.EnableHotkeys()
return

Hkey_Change:
  ; TODO: use A_GuiControl
  newHk := %A_GuiControl%
  cmdHk := "CMD" SubStr(A_GuiControl, 4)
  strOldHk := app.Get(cmdHk)
  
  if(strOldHk <> newHk && app.hotkeys.hasKey(newHk))
  {
    app.Forms["HkList"].controlsByNames.SetValue("")
    ; TODO: notify
  }
return

BtnHkListOk_Click:
;   OutputDebug Label BtnHkListOk_Click:
  app.Forms["HkList"].Submit()
  for strHk, hk in app.hotkeys
  {
;     OutputDebug `tChecking if %strHk% is being replaced
    tmp_HotkeyControlVar := hk.label
    StringReplace, tmp_HotkeyControlVar, tmp_HotkeyControlVar, CMD_, HkeyHK_
    strNewHk := %tmp_HotkeyControlVar%
    
    if(strHk = strNewHk)
      continue
    
;     OutputDebug `t%tmp_HotkeyControlVar% contains %strNewHk% for %strHk%
    
    app.ReplaceHotkey(strHk, strNewHk)

    if ErrorLevel 
    {
      msgbox, 48, % app.ProductName, % _t("MSG_RegisterHkFailed") ": " strNewHk "`n" _t("MSG_HkWillBeRestored") ":" strHk
      app.Forms["HkList"].controlsByNames[tmp_HotkeyControlVar].SetValue(app.Get(hk.Label))
    }
    else
    {
;       OutputDebug `tapp.Hotkeys[%strNewHk%].Enable()
      app.Hotkeys[strNewHk].Enable()
    }
  }
  app.HideForm("HkList")
return

HkListClose:
HkListEscape:
BtnHkListCancel_Click:
  app.HideForm("HkList")
  app.EnableHotkeys()
return
; ============================ Mouse input events ==============================

LButtonUp:
	$LastKey := "LButton"
	TriggerInputEvent("MouseClick")
	return
  
MButtonUp:
	$LastKey := "MButton"
	TriggerInputEvent("MouseClick")
	return
  
RButtonUp:
	$LastKey := "RButton"
	TriggerInputEvent("MouseClick")
	return

; ======================== A common Gui control event ==========================

GuiControlEvent:
; OutputDebug GuiControlEvent
return