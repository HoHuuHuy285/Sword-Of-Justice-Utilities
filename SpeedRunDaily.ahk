#Requires AutoHotkey v2.0
#SingleInstance Force

;Import lib
#Include "lib/HandleSetting.ahk"
#Include "lib/FunctionHelper.ahk"

; --- CÀI ĐẶT CẤU HÌNH HỆ THỐNG ---
InstallMouseHook()
InstallKeybdHook()
A_MaxHotkeysPerInterval := 1000
SetStoreCapslockMode(false)
ListLines(false)
ProcessSetPriority("A")
SetKeyDelay(-1, -1)
SetDefaultMouseSpeed(0)
SetMouseDelay(-1)
SetWinDelay(-1)
SetControlDelay(-1)


;q::{
;ChangeUser()
;}
