#SingleInstance force
SendMode Input
SetWorkingDir %A_ScriptDir% 

OnExit, sub_exit
if (midi_in_Open(0))
    ExitApp
Menu TRAY, Icon, icon4.ico

;--------------------  Midi "hotkey" mappings  -----------------------
listenNote(49, "chrome")
listenNote(51, "firefox")
listenNote(54, "vscode")
listenNote(56, "notepadPlus")
listenNote(58, "notepad")
listenNote(61, "volumeUp")
listenNote(63, "volumeDown")
listenNote(66, "mydeskC")
listenNote(68, "mydeskD")
; listenNote(70, "") 	not used

listenNote(48, "textHtmlstart")
listenNote(50, "textHtmlstartInput")
listenNote(52, "htmlTable")
listenNote(53, "codeInText")
listenNote(55, "highlighText")
; listenNote(57, "")	not used
; listenNote(59, "")	not used

; listenNote(60, "")	not used
; listenNote(62, "")	not used
listenNote(64, "ctrlshiftP")
listenNote(65, "ctrlshiftOE")

listenNoteRange(67, 69, "playSomeSounds1", 0x02)
listenNoteRange(71, 72, "playSomeSounds2", 0x02)

return
;----------------------End of auto execute section--------------------

sub_exit:
    midi_in_Close()
ExitApp

;-------------------------Miscellaneous hotkeys-----------------------
Esc::ExitApp

;-------------------------Midi "hotkey" functions---------------------
; midi controller - black keys
;------ application ------
chrome(note, vel) ; key 49
{
    if (vel)
		{
		run, "C:\Program Files\Google\Chrome\Application\chrome.exe"
		}
}
;------ application ------
firefox(note, vel) ; key 51, (vel >= 80) without it starts 2x
{
    if (vel >= 80)
		{
		run, "C:\Program Files\Mozilla Firefox\firefox.exe"
		}
}
;------ application ------
vscode(note, vel) ; key 54, (vel >= 80) without it starts 2x
{
    if (vel >= 80)
		{
		run, "D:\ProgrammeD\Microsoft VS Code\Code.exe"
		}
}
;------ application ------
notepadPlus(note, vel) ; key 56
{
    if (vel)
		{
		run, "C:\Program Files\Notepad++\notepad++.exe"
		}
}
;------ application ------
notepad(note, vel) ; key 58, (vel >= 70) without it starts 2x
{
    if (vel >= 70)
		{
		run, "C:\Windows\System32\notepad.exe"
		}
}
;------ key combinations - volume ------
volumeUp(note, vel) ; key 61,
{
    if (vel <= 90 && vel > 30)
		{
			Send {Volume_up +5} ; 0 means sound off , sets tone to 10, +10 is increased by 10
		}
}

volumeDown(note, vel) ; key 63,
{
    if (vel <= 90 && vel > 30)
		{
			Send {Volume_Mute}
		}
}


;------ application - explorer ------
mydeskC(note, vel) ; key 66 (C3), (vel >= 70) without it starts 2x
{
    if (vel >= 70)
		{
		run, "%windir%\explorer.exe"
		}
}
;------ application - explorer ------
mydeskD(note, vel) ; key 69
{
    if (vel)
		{
		run, "D:\EigeneDateinProgramming"
		}
}

; midi controller - white keys
;------ text ------
; all special characters i.e. {#} must be set in {}, for {space} http://www.autohotkey.com/docs/commands/Send.htm 
; https://www.autohotkey.com/docs/v1/Hotkeys.htm
textHtmlstart(note, vel) ; key 48,  (vel <= 90 && vel > 30) without it starts 2x
{
	if (vel <= 90 && vel > 30)
		{
			Send, <{!}DOCTYPE html>`n ; first line
			send, <html>`n
			send, {space}{space}<head>`n
			send, {space}{space}{space}{space}<meta charset="utf-8">`n
			send, {space}{space}{space}{space}<meta name="viewport" content="width=device-width, initial-scale=1">`n
			send, {space}{space}{space}{space}<meta name="description" content="" />`n
			send, {space}{space}{space}{space}<title>Title</title>`n ; input
			send, {space}{space}</head>`n
			send, {space}{space}<body>`n
			send, {space}{space}{space}{space}<script src=""></script>`n
			send, {space}{space}</body>`n
			send, </html>`n
		}
}

textHtmlstartInput(note, vel) ; key 50,  (vel <= 90 && vel > 30) without it starts 2x
{
	if (vel <= 90 && vel > 30)
		{
			InputBox, UserInput, Title (head) name ; fill in value between quotes
			Send, <{!}DOCTYPE html>`n ; first line
			send, <html>`n
			send, {space}{space}<head>`n
			send, {space}{space}{space}{space}<meta charset="utf-8">`n
			send, {space}{space}{space}{space}<meta name="viewport" content="width=device-width, initial-scale=1">`n
			send, {space}{space}{space}{space}<meta name="description" content="" />`n
			send, {space}{space}{space}{space}<title>"%UserInput%"</title>`n ; input
			send, {space}{space}</head>`n
			send, {space}{space}<body>`n
			send, {space}{space}{space}{space}<script src=""></script>`n
			send, {space}{space}</body>`n
			send, </html>`n
		}
}

htmlTable(note, vel) ; key 52,  (vel <= 90 && vel > 30) without it starts 2x
{
	if (vel <= 90 && vel > 30)
		{
			Send, <table>`n 
			send, {space}{space}<tr>`n
			send, {space}{space}{space}{space}<th></th><th></th>`n
			send, {space}{space}</tr>`n
			send, {space}{space}<tr>`n
			send, {space}{space}{space}{space}<td></td>`n
			send, {space}{space}{space}{space}<td></td>`n
			send, {space}{space}</tr>`n
			send, {space}{space}<tr>`n
			send, {space}{space}{space}{space}<td></td>`n
			send, {space}{space}{space}{space}<td></td>`n
			send, {space}{space}</tr>`n
			send, </table>`n
		}
}

codeInText(note, vel) ; key 53,  (vel <= 90 && vel > 30) without it starts 2x
{
	if (vel <= 90 && vel > 30)
		{
			Send, <i class="highlight-text"></i>`n 
		}
}

highlighText(note, vel) ; key 55,  (vel <= 90 && vel > 30) without it starts 2x
{
	if (vel <= 90 && vel > 30)
		{
			Send, <span class="text-styling"></span>`n 
		}
}


;------ key combinations - https://www.autohotkey.com/docs/v2/howto/SendKeys.htm ------
; ctrl + shift + p , show all comments
ctrlshiftP(note, vel) ; key 64
{
    if (vel <= 90 && vel > 30)
		{
			Send ^+p
		}
}
; ctrl + shift + ö terminal
ctrlshiftOE(note, vel) ; key 65
{
    if (vel <= 90 && vel > 30)
		{
			Send  ^+U
		}
}

;------ sounds ------
playSomeSounds1(note, vel) ; key 67, 69
{
	if (vel >= 70) ; vel == 0 means note off , my midi-controller 0-127
	{
		SoundPlay sounds/sound%note%.mp3
	}
}

playSomeSounds2(note, vel) ; key 71, 72
{
	if (vel >= 70) ; vel == 0 means note off , my midi-controller 0-127
	{
		SoundPlay sounds/sound%note%.mp3
	}
}


;-------------------------  Midi input library  ----------------------
#include midi_in_lib.ahk



/*
;------ application ------
githubDesktop(note, vel) ; 
{
    if (vel)
		{
		run, "C:\Users\Bella\AppData\Local\GitHubDesktop\GitHubDesktop.exe"
		}
}

;------ key combinations ctrl + A ------
 https://www.autohotkey.com/docs/v2/howto/SendKeys.htm 

ctrlA(note, vel) 
{
    if (vel <= 90 && vel > 30)
		{
			Send ^a
		}
}

*/