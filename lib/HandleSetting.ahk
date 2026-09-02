#Requires AutoHotkey v2.0

ChangeUser(){
    Send("{Esc}")
    Sleep(150)
    Click 1520, 234
    l_Start := A_TickCount
        Loop {
            me := FastPixelSearch(1822, 865, 1, 1)
            if (me.Search(0xffffff)) {  ; Nếu tìm thấy
                Click 1822, 865
                return 0
            }
            if (A_TickCount - l_Start >= 4000)
                return 2
        }
}
