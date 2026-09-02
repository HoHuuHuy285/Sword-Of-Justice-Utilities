#Requires AutoHotkey v2.0
#SingleInstance Force

;Import lib
#Include "lib/HandleSetting.ahk"
#Include "lib/FunctionHelper.ahk"
#Include "lib/HandleTheThang.ahk"
#Include "lib/PostMHL.ahk"
#Include "lib/VanChuyenBang.ahk"

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

q::{
    ;OpenFilmGroup()
    ;ChangeUser()
    ;ClaimTheThang()
    ;Click 1506, 473
    VanChuyenBang()
}

e::{
PostMHL()
}

r::{
    Click 1509, 822 ;Click vào "Chế Tạo"
    Sleep(100)
    Click 566, 823 ;Click vào "Thiết kế tạo hình"
    Sleep(300)
    Click 1853, 984 ;Click vào "Tải lên"
    Sleep(300)
    Click 1598, 843 ;Click vào "Xác nhận tải lên"
    Sleep(800)
    ; Nhấn 3 lần Esc để thoát ra ngoài
    Send("{Esc}")
    Sleep(300)
    Send("{Esc}")
    Sleep(300)
    Send("{Esc}")
    Sleep(300)
    ; ------------------------

}

#HotIf
