; Process command-line parameters
if 0 > 0
{
  Loop, %0%
  {
    param := %A_Index%
    if(param = "-x")
    {
      app.Exit()
    }
    else if(param = "-d")
    {
      ; TODO: Delete appropriate customizable settings, files and directories to restore defaults.
    }
  }
}