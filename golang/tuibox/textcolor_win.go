package tui

import(
	"syscall"
)

var(
	kernel32 *syscall.LazyDLL
	proc *syscall.LazyProc
	handle uintptr
)

func init(){
	Init()	
}

func Init(){
	kernel32 = syscall.NewLazyDLL("kernel32.dll")
	proc = kernel32.NewProc("SetConsoleTextAttribute")
}

func SetColor(val int){//7 White Black
	//handle, _, _ := proc.Call(uintptr(syscall.Stdout), uintptr(val)) //12 Red light
	proc.Call(uintptr(syscall.Stdout), uintptr(val)) //12 Red light
}

func Close(){
	CloseHandle := kernel32.NewProc("CloseHandle")
	CloseHandle.Call(handle)
}