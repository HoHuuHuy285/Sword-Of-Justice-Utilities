#Requires AutoHotkey v2.0

NhanVanChuyenBang(){
    l_Start := A_TickCount
        Loop {
            me := FastPixelSearch(774, 69, 1, 1)
            if (me.Search(0xffffff)) {  ; Nếu tìm thấy
                VanChuyenBang()
                return true
            }
            Click 1506, 473 ;Click vào "Vận Chuyển Bang"
            if (A_TickCount - l_Start >= 2000)
                return false
        }
}

VanChuyenBang() {
    l_Start := A_TickCount
        Loop {
            me := FastPixelSearch(1598, 929, 1, 1)
            if (me.Search(0x001020)) {  ; Nếu tìm thấy
                Click 1646,905
                Sleep(425)
                Send("{Space}")
                Sleep(225)
                Click 1646,905 ;Click thoat mong hoa luc
                Sleep(325)
                Click 946, 761 ;Click bat ky de thoat
                return true
            }
            Click 1579, 730 ;Click vào "Nộp Vật Phẩm"
            Sleep(100)
            if (A_TickCount - l_Start >= 5000) ;Tang them thoi gian
                return false
        }
}
