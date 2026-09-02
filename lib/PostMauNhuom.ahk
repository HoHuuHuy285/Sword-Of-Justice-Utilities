#Requires AutoHotkey v2.0

PostMauNhuom() {
    l_Start := A_TickCount
        Loop {
            me := FastPixelSearch(1900, 955, 1, 1)
            if (me.Search(0xffffff)) {  ; Nếu tìm thấy
                Sleep(300)
                Click 1853, 984 ;Click vào "Tải lên"
                Sleep(300)
                Click 1598, 843 ;Click vào "Xác nhận tải lên"
                WaitProcessDone()
                return 0
            }
            if (A_TickCount - l_Start >= 2000)
                return 2
        }
}

WaitProcessDone(){
    l_Start := A_TickCount
        Loop {
            me := FastPixelSearch(1814,819, 1, 1)
            if (me.Search(0xffffff)) {
                ; Nhấn 3 lần Esc để thoát ra ngoài
                Send("{Esc}")
                Sleep(200)
                Send("{Esc}")
                Sleep(200)
                Send("{Esc}")
                Sleep(200)
            }
            if (A_TickCount - l_Start >= 2000)
                return 2
        }
}
