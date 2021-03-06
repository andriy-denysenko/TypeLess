; Declare a data object to be filled-in by command-line.ahk and config.ahk
global configData := {}
configData.CompanyName := "IngulSoft"
configData.ProductName := "TypeLess"
configData.ProductVersion := "0.0.1"
; Configure default settings
configData.RecentFiles := ""
configData.CurrentFile := ""
configData.InterfaceLanguage := "en-US"
configData.StartOnLogin := true
configData.CreateDesktopShortcut := true

configData.CMD_ListHotstrings := "^!F4"
configData.CMD_AddHotstring := "^!F5"
configData.CMD_ReplaceSelection := "^!F6"
configData.CMD_ShowSettings := "^!F7"
configData.CMD_FilterOn := "^!F8"

configData.EndChars := "-()[]{}:;'""/\,.?!"
configData.EndKeys := "Enter|Tab|Space"
configData.FilterOn := true

#include %A_ScriptDir%\default-strings.ahk
configData.DefaultStrings := strings ; strings is set in default-strings.ahk
strings := ""

; Initialize the application
app.Initialize(configData.clone())
configData := ""

if ErrorLevel = 1
{
  msgbox, 16, % app.ProductName, Could not create the data directory.`nPlease notify me about this issue (denysenko.andriy@gmail.com).
  exitapp
}
else if ErrorLevel = 2
{
  msgbox, 16, % app.ProductName, Could not create the default configuration file.`nPlease notify me about this issue (denysenko.andriy@gmail.com).
  exitapp
}
else if ErrorLevel = 3
{
  msgbox, 16, % app.ProductName, Could not create the interface languages directory.`nPlease notify me about this issue (denysenko.andriy@gmail.com).
  exitapp
}
else if ErrorLevel = 4
{
  msgbox, 16, % app.ProductName, Could not store a setting in the configuration file.`nPlease notify me about this issue (denysenko.andriy@gmail.com).
  exitapp
}
else if ErrorLevel = 5
{
  msgbox, 16, % app.ProductName, Could not store default strings in a language file.`nPlease notify me about this issue (denysenko.andriy@gmail.com).
}
else if ErrorLevel = 6
{
  msgbox, 16, % app.ProductName, Could not read strings from a language file.`nPlease check language files.
}
; The application is initialized

; tmp
; #include %A_ScriptDir%\ru-RU.ahk
; app.loc.CreateLanguageFile(strings._langId, strings._langName, strings)
; /tmp

g_startOnLogin := app.Get("StartOnLogin")
if(g_startOnLogin)
{
  FS_StartupShortcutCreate(A_ScriptFullPath)
}
else
{
  FS_StartupShortcutRemove(A_ScriptFullPath)
}

g_CreateDesktopShortcut := app.Get("CreateDesktopShortcut")
if(g_CreateDesktopShortcut)
{
  FS_DesktopShortcutCreate(A_ScriptFullPath)
  ; TODO: check ErrorLevel
  app.Set("CreateDesktopShortcut", false, true)
}