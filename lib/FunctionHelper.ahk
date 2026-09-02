#Requires AutoHotkey v2.0

class FastPixelSearch
{
    __New(x, y, w, h) {
        this.hBM := FastPixelSearch.Api.HBitmapFromScreen(x, y, w, h, &pvBits)
        this.pvBits := pvBits
        this.w := w
        this.size := w * h
    }

    Search(colorRGB) {
        static bin := 0
        if !bin
            bin := FastPixelSearch.Api.GetBin()
        if !(colorRGB >> 24)
            colorRGB |= 0xFF000000

        byte := DllCall(bin, "Ptr", this.pvBits, "UInt", this.size, "UInt", colorRGB, "Int")
        if (byte == this.pvBits + this.size * 4)
            return false

        offset := (byte - this.pvBits) // 4
        return {x: Mod(offset, this.w), y: offset // this.w}
    }

    class Api
    {
        static GetBin() {
            static PAGE_EXECUTE_READWRITE := 0x40, CRYPT_STRING_BASE64 := 0x1
            code := A_PtrSize = 8 ? "idJIjQSRSDnBcw9EOQF1BInI6wZIg8EE6+zD"
                                  : "VYnli1UIi0UMi00QjQSCOcJzDTkKdQSJ0OsFg8IE6+9dww=="
            size := StrLen(RTrim(code, "=")) * 3 // 4
            bin := DllCall("GlobalAlloc", "UInt", 0, "Ptr", size, "Ptr")
            old := 0
            DllCall("VirtualProtect", "Ptr", bin, "Ptr", size, "UInt", PAGE_EXECUTE_READWRITE, "UInt*", &old)
            DllCall("crypt32\CryptStringToBinary", "Str", code, "UInt", 0, "UInt", CRYPT_STRING_BASE64
                                                 , "Ptr", bin, "UInt*", &size, "Ptr", 0, "Ptr", 0)
            return bin
        }

        static HBitmapFromScreen(X, Y, W, H, &pvBits) {
            static rop := 0x00CC0020 | 0x40000000 ; SRCCOPY | CAPTUREBLT
            hDC := DllCall("GetDC", "Ptr", 0, "Ptr")
            hBM := this.CreateDIBSection(W, H, hDC, &pvBits)
            hMDC := DllCall("CreateCompatibleDC", "Ptr", hDC, "Ptr")
            hObj := DllCall("SelectObject", "Ptr", hMDC, "Ptr", hBM, "Ptr")
            DllCall("BitBlt", "Ptr", hMDC, "Int", 0, "Int", 0, "Int", W, "Int", H
                            , "Ptr", hDC, "Int", X, "Int", Y, "UInt", rop)
            DllCall("SelectObject", "Ptr", hMDC, "Ptr", hObj, "Ptr")
            DllCall("DeleteDC", "Ptr", hMDC)
            DllCall("ReleaseDC", "Ptr", 0, "Ptr", hDC)
            return hBM
        }

        static CreateDIBSection(w, h, hDC, &pvBits) {
            BITMAPINFO := Buffer(40, 0)
            NumPut("UInt", 40, "Int", w, "Int", -h, "UShort", 1, "UShort", 32, BITMAPINFO)
            pvBits := 0
            hBM := DllCall("CreateDIBSection", "Ptr", hDC, "Ptr", BITMAPINFO, "UInt", 0
                                              , "Ptr*", &pvBits, "Ptr", 0, "UInt", 0, "Ptr")
            return hBM
        }
    }

    __Delete() {
        DllCall("DeleteObject", "Ptr", this.hBM)
    }
}

px(color, x1 := "", y1 := "", x2 := "", y2 := "") {
    if (x1 = "" && y1 = "" && x2 = "" && y2 = "") {
        x1 := 0
        y1 := 0
        x2 := A_ScreenWidth
        y2 := A_ScreenHeight
    }

    width := x2 - x1
    height := y2 - y1

    static hdc := 0, hbm := 0, obm := 0, pBits := 0

    if !hdc {
        hdc := DllCall("CreateCompatibleDC", "Ptr", 0, "Ptr")
        bi := Buffer(40, 0)
        NumPut("UInt", 40, "Int", width, "Int", -height, "UShort", 1, "UShort", 32, bi)
        pBits := 0
        hbm := DllCall("CreateDIBSection", "Ptr", hdc, "Ptr", bi, "UInt", 0, "Ptr*", &pBits, "Ptr", 0, "UInt", 0, "Ptr")
        obm := DllCall("SelectObject", "Ptr", hdc, "Ptr", hbm, "Ptr")
    }

    static sdc := DllCall("GetDC", "Ptr", 0, "Ptr")

    DllCall("gdi32\BitBlt"
            , "Ptr", hdc
            , "Int", 0, "Int", 0
            , "Int", width, "Int", height
            , "Ptr", sdc
            , "Int", x1, "Int", y1
            , "UInt", 0x00CC0020 | 0x40000000)

    static bin := 0
    if !bin {
        code := (A_PtrSize == 8)
        ? "idJIjQSRSDnBcw9EOQF1BInI6wZIg8EE6+zD"
        : "VYnli1UIi0UMi00QjQSCOcJzDTkKdQSJ0OsFg8IE6+9dww=="
        padding := (code ~= "==$") ? 2 : ((code ~= "=$") ? 1 : 0)
        size := 3 * (StrLen(code) // 4) - padding
        bin := DllCall("GlobalAlloc", "UInt", 0, "UPtr", size, "Ptr")
        old := 0
        DllCall("VirtualProtect", "Ptr", bin, "Ptr", size, "UInt", 0x40, "UInt*", &old)
        DllCall("crypt32\CryptStringToBinary", "Str", code, "UInt", 0, "UInt", 0x1, "Ptr", bin, "UInt*", &size, "Ptr", 0, "Ptr", 0)
    }

    byte := DllCall(bin, "Ptr", pBits, "UInt", width * height, "UInt", color, "Int")
    if (byte == pBits + width * height * 4) {
        return {x: -1, y: -1}
    }

    pixelOffset := (byte - pBits) // 4
    x := x1 + Mod(pixelOffset, width)
    y := y1 + pixelOffset // width

    return {x: x, y: y}
}
