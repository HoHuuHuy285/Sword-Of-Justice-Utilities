#Requires AutoHotkey v2.0

NhanVanChuyenBang(){
    l_Start := A_TickCount
        Loop {
            me := FastPixelSearch(774, 69, 1, 1)
            if (me.Search(0xffffff)) {  ; Nếu tìm thấy
                VanChuyenBang()
                return 0
            }
            Click 1506, 473 ;Click vào "Vận Chuyển Bang"
            if (A_TickCount - l_Start >= 2000)
                return 2
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
                Click 1646,905
                return 0
            }
            Click 1579, 751 ;Click vào "Nộp Vật Phẩm"
            if (A_TickCount - l_Start >= 2000)
                return 2
        }
}
