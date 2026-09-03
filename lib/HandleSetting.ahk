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
                WaitApply()
                return true
            }
            if (A_TickCount - l_Start >= 4000)
                return false
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

WaitApply(){
l_Start := A_TickCount
    Loop {
        me := FastPixelSearch(1647, 915 , 1, 1)
        if (me.Search(0xffffff)) {
            Click 1638, 914 ;Click vào "Áp Dụng"
            Sleep(1000)
            Send("{Esc}")
            return true
        }
        if (A_TickCount - l_Start >= 4000)
            return false
    }
}
