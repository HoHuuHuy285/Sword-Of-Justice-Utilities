#Requires AutoHotkey v2.0

PostMHL(){
    Click 165,906
    l_Start := A_TickCount
        Loop {
            me := FastPixelSearch(1147, 745, 1, 1)
            if (me.Search(0xffffff)) {  ; Nếu tìm thấy
                Click 1363, 490 ;Click vào "Ghi lại khoảnh khắc này"
                Sleep(300)
                SendInput("a")
                Click 1563, 818 ;Click vào "Đăng"
                Sleep(300) ;Chờ một chút để ổn định giao diện
                return 0
            }
            if (A_TickCount - l_Start >= 1500)
                return 2
        }
}
