package term

import(
	"bytes"
	"strings"
	"fmt"
)

// 	   0123456789ABCDEF
// 2500─━│┃┄┅┆┇┈┉┊┋┌┍┎┏
// 2510┐┑┒┓└┕┖┗┘┙┚┛├┝┞┟
// 2520┠┡┢┣┤┥┦┧┨┩┪┫┬┭┮┯
// 2530┰┱┲┳┴┵┶┷┸┹┺┻┼┽┾┿
// 2540╀╁╂╃╄╅╆╇╈╉╊╋╌╍╎╏
// 2550═║╒╓╔╕╖╗╘╙╚╛╜╝╞╟
// 2560╠╡╢╣╤╥╦╧╨╩╪╫╬╭╮╯
// 2570╰╱╲╳╴╵╶╷╸╹╺╻╼╽╾╿

func DrawFrame(msg string, x int, y int, w int, h int){
	SetPos(x,y)
	DrawTitleHeader(msg,w)
	defer DrawFeeter(w)
	SetPos(x,y+1)
	for index := 1; index < h; index++ {
		DrawBody(w)
		SetPos(x,y+index)
	}
}

func DrawMsg(msg string, x int, y int){
	SetPos(x,y)
	fmt.Printf(msg)
}

func DrawBox(x int, y int, w int, h int){
	SetPos(x,y)
	DrawHeader(w)
	defer DrawFeeter(w)
	SetPos(x,y+1)
	for index := 1; index < h; index++ {
		DrawBody(w)
		SetPos(x,y+index)
	}
}

func DrawTitleHeader(title string, w int){
	lw := w - len(title)-1
	if lw<0{
		lw = 0
	}
	fmt.Printf("┏%s%s┓",title,strings.Repeat("━",lw))
}

func DrawHeader(w int){
	fmt.Printf(line(w,"┏","━","┓"))
}

func DrawFeeter(w int){
	fmt.Printf(line(w,"┖","━","┛"))
}

func DrawBody(w int){
	fmt.Printf(line(w,"┃"," ","┃"))
}

func line(w int, h string, b string, t string) string{
	var buffer bytes.Buffer
	buffer.WriteString(h)
	buffer.WriteString(strings.Repeat(b,w-1))
	buffer.WriteString(t)
	return buffer.String()
}