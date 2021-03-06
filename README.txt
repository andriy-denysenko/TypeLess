TypeLess is an autoreplace utility. It allows you to assign abbreviations for words and phrases of your choice (e.g. most often used by you) so that the computer replaced abbreviations with their respective phrases.

Compiled versions of TypeLess require no installation. Just unpack the archive you downloaded to a folder of your choice (currently, not in or under Program Files on Windows Vista and later) and launch TypeLess.exe.

When launched for the first time, TypeLess creates a startup shortcut, which you can disable in the Settings form (Ctrl+Alt+F7 by default or Settings item in the tray menu).

The Settings form also allows you to switch autoreplace on or off (as well as Ctrl+Alt+F8 and the respective tray menu item do), edit ending characters and choose the interface language (only English and Russian localizations are available so far, and you are welcome to comment on them).

Compatibility

TypeLess supports Windows XP and later. It is tested on Windows XP SP3, and partially on Windows Vista and Windows 7 (all 32-bit so far).

Currently, TypeLess can not create files under Program Files on Windows Vista and later, neither do I using AutoHotkey Wink . So, it will not work if placed there. But it can work in directories that do not require special privileges to create files in them.

If you downloaded the source code, use AutoHotkey_L 1.1.05.06 (1.1.05.05 is probably compatible too) and start TypeLess.ahk to run the script.

Features

- Allows using several autoreplace lists (one at a time) - you can create a new file, open an existing file or choose a recent file using the File menu.

- Allows adding an abbreviation for the text selected in the active window (Ctrl+Alt+F5 by default). If the selected text is an abbreviation or a phrase existing in the current list, then the editor shows an entry for the respective abbreviation or phrase. If there is no selection or the menu command is used to add an abbreviation, then TypeLess uses the clipboard content as a phrase.

- Uses a hotkey (Ctrl+Alt+F4 by default) or an Abbreviation list menu item to open the list of abbreviations and phrases, which contains buttons to add, edit or remove an abbreviation (or you can double-click an item in the list to edit it).

- Allows to replace an abbreviation selected in an active window (Ctrl+Alt+F6 by default).

- Supports some variables for keys (Left, Right, Up, Down) and date/time (TimeDate - time and long date, ShortDate, LongDate, and YearMonth). Enclose variables into square brackets (e.g. [Left 4] to press the left arrow four times).

- Shows a tooltip when an abbreviation is recognized.

- Allows hotkey editing.

Known limitations

Abbreviations may have no effect on Windows Vista or later if the active window is running with administrative privileges and the script is not. This is due to a security mechanism called User Interface Privilege Isolation.

Antiviral software may got scared of compressed compiled versions. This is due to advanced code protection. Non-compiled versions are larger in size and do not cause antiviral software to suspect them of being malware.

If you want to use a compressed version, and your antivirus asks you what to do, please tell you antivirus to launch TypeLess.exe in normal mode instead of running in a sandbox. And do not forget to check an option to do so each time.

Licensing information

TypeLess 0.0.1 including all builds is provided free of charge, but you are welcome to support its development. Please contact me (denysenko.andriy at gmail.com) for payment details.

No Warranty: TypeLess 0.0.1 including all builds is provided "AS IS". TO THE EXTENT PERMITTED BY APPLICABLE LAW, ANDRIY DENYSENKO DISCLAIMS ALL WARRANTIES EITHER EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION ANY WARRANTY OF OF NON-INFRINGEMENT, NONINTERFERENCE, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE REGARDING THE CODE OR TECHNICAL SUPPORT, IF ANY.

Limitation of Liability: ANDRIY DENYSENKO IS NOT LIABLE FOR ANY DIRECT OR INDIRECT DAMAGES, INCLUDING WITHOUT LIMITATION, LOST PROFITS, LOST SAVINGS, LOST BEARSKIN BEFORE SHOOTING THE BEAR, OR ANY INCIDENTAL, SPECIAL, OR OTHER ECONOMIC CONSEQUENTIAL DAMAGES, EVEN IF ANDRIY DENYSENKO IS INFORMED OF THEIR POSSIBILITY. SOME JURISDICTIONS DO NOT ALLOW THE EXCLUSION OR LIMITATION OF INCIDENTAL OR CONSEQUENTIAL DAMAGES, SO THE ABOVE EXCLUSION OR LIMITATION MAY NOT APPLY TO YOU. 