#Requires AutoHotkey v2.0
#SingleInstance Force

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


; --- NÚT BẬT / TẮT TOÀN BỘ SCRIPT (Ví dụ ở đây dùng phím F4) ---
; Lệnh này đặt ngoài điều kiện game để bạn có thể tắt script bất cứ lúc nào
~F4:: {
    Suspend(-1) ; Đảo ngược trạng thái Suspend (Bật <-> Tắt)

    if (A_IsSuspended) {
        ; Nếu vừa TẮT script: Phát 2 tiếng bíp ngắn, trầm
        SoundBeep(1000, 100)
        SoundBeep(1000, 100)
    } else {
        ; Nếu vừa BẬT script: Phát 1 tiếng bíp cao, vang
        SoundBeep(1500, 150)
    }
}


; --- ĐĂNG KÝ HOTKEY THEO NGỮ CẢNH (Dành riêng cho Nghịch Thủy Hàn) ---
HotIfWinActive("ahk_exe nshm.exe")

key := "f"
Hotkey("$" . key, Fkey)

key := "e"
Hotkey("$" . key, Fkey1)

key := "LShift"
Hotkey("$" . key, Fkey2)

HotIf()


; --- CÁC HÀM CALLBACK CỦA HOTKEY ---

Fkey(ThisHotkey) {
    Critical()
    hotkeyName := SubStr(ThisHotkey, 2)
    while GetKeyState(hotkeyName, "P") {
        SendEvent("{F1}")
        Delay(0.005)
    }
}

Fkey1(ThisHotkey) {
    Critical()
    hotkeyName := SubStr(ThisHotkey, 2)
    while GetKeyState(hotkeyName, "P") {
        SendEvent("e")
        Delay(0.005)
    }
}

Fkey2(ThisHotkey) {
    Critical()
    hotkeyName := SubStr(ThisHotkey, 2)
    while GetKeyState(hotkeyName, "P") {
        SendEvent("{*}")
        Delay(0.005)
    }
}

; --- HÀM DELAY ĐỘ CHÍNH XÁC CAO ---
Delay(D := 0.001) {
    Critical()
    static F := 0
    pTick := 0, cTick := 0
    if (F == 0) {
        DllCall("QueryPerformanceFrequency", "Int64*", &F)
    }
    DllCall("QueryPerformanceCounter", "Int64*", &pTick)
    cTick := pTick
    while (((pTick - cTick) / F) < D) {
        DllCall("QueryPerformanceCounter", "Int64*", &pTick)
        Sleep(-1)
    }
    return Round((pTick - cTick) / F, 3)
}
