#Requires AutoHotkey v2.0

ClaimTheThang(){
    l_Start := A_TickCount
        Loop {
            me := FastPixelSearch(1523, 938, 1, 1)
            if (me.Search(0x011120)) {  ; Nếu tìm thấy
                Click 1553, 915 ;Click vào "Quay cùng kiểu"
                Sleep(300)
                Click 1553, 915 ;Click vào "Áp Dụng"
                Sleep(300)
                return 0
            }
            if (A_TickCount - l_Start >= 2000)
                return 2
        }
}
