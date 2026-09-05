#Requires AutoHotkey v2.0

ClaimTheThangAndPostMHL(){
    l_Start := A_TickCount
        Loop {
            me := FastPixelSearch(1523, 938, 1, 1)
            if (me.Search(0x011120)) {  ; Nếu tìm thấy
                Click 1553, 915 ;Click vào "Nhận"
                Sleep(300)
                Click 1553, 915 ;Click vào "Nhấn vào bất kỳ để thoát"
                Sleep(300)

                PostMHL()
                return 0
            }

            ; TH 2: Tìm thấy tại vị trí (111, 200)
            me2 := FastPixelSearch(39, 66, 1, 1)
            if (me2.Search(0xffffff)) { ; <-- Nếu dùng mã màu khác, hãy thay 0xffffff tại đây
                PostMHL() ; Chỉ thực thi PostMHL()
                return 0
            }

            ; Giảm tải CPU giúp tránh lag/đơ máy
            Sleep(15)

            if (A_TickCount - l_Start >= 2000)
                return 2
        }
}


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
            if (A_TickCount - l_Start >= 2000) ;1500ms bị lỗi và tăng thời gian lên 2000
                return 2
        }
}
