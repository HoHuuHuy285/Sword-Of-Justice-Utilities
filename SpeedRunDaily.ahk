#Requires AutoHotkey v2.0
#SingleInstance Force

;Import lib
#Include "lib/HandleSetting.ahk"
#Include "lib/FunctionHelper.ahk"
#Include "lib/HandleTheThangAndPostMHL.ahk"
#Include "lib/VanChuyenBang.ahk"
#Include "lib/PostMauNhuom.ahk"
#Include "lib/AcceptDongTacDoi.ahk"

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


#HotIf WinActive("ahk_class UnityWndClass")

1::{
    ClaimTheThangAndPostMHL()
}

2::{
    AcceptDongTacDoi()
}

c::{
    ChangeUser()
}

q::{
    OpenFilmGroup()
}

e::{
    NhanVanChuyenBang()
}

r::{
    Click 1509, 822 ;Click vào "Chế Tạo"
    Sleep(100)
    Click 566, 823 ;Click vào "Thiết kế tạo hình"
    PostMauNhuom()
    ClaimTheThangAndPostMHL()
    ;Send("{f}")
}

#HotIf
