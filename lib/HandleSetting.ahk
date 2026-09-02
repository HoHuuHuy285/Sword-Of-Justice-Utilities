#Requires AutoHotkey v2.0

OpenFilmGroup(){
    Send("{Esc}")
    Sleep(150)
    Click 1520, 234
    l_Start := A_TickCount
        Loop {
            me := FastPixelSearch(1822, 865, 1, 1)
            if (me.Search(0xffffff)) {  ; Nếu tìm thấy
                Click 1822, 865 ;Click vào "Quay cùng kiểu"
                Sleep(300)
                Click 1638, 914 ;Click vào "Áp Dụng"
                Sleep(1000)
                Send("{Esc}")
                return 0
            }
            if (A_TickCount - l_Start >= 4000)
                return 2
        }
}


ChangeUser(){
    Send("{Esc}")
    Sleep(150)
    Click 1860, 640 ;Click icon "Cài Đặt
    Sleep(300)
    Click 884, 305 ;Click Chuyển đổi nhân vật
    Sleep(400) ;Sleep 400 thường sẽ là thời gian delay của việc mở popup có Space để xác nhận
    Send("{Space}")
}
