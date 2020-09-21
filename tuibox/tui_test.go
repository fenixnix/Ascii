package tui

import "testing"
import(
	"fmt"
	"syscall"
)
func Test(t*testing.T){
	for l := 0; l<6;l++ {
		for c:=0;c<4;c++{
			NewWire(l,c).Print(5)
		}
	}
	menu:=NewMenu([]string{"a","b","c",})
	menu.Print()
	ColorPrintln("hello world",12)
}
func ColorPrintln(s string, i int) {
    kernel32 := syscall.NewLazyDLL("kernel32.dll")
    proc := kernel32.NewProc("SetConsoleTextAttribute")
    handle, _, _ := proc.Call(uintptr(syscall.Stdout), uintptr(i)) //12 Red light

    fmt.Println(s)

    handle, _, _ = proc.Call(uintptr(syscall.Stdout), uintptr(7)) //White dark
    CloseHandle := kernel32.NewProc("CloseHandle")
    CloseHandle.Call(handle)
}