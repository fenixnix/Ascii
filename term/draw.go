package term

import(
	"fmt"
	//"bytes"
)

//组织好string一次性{Printf}
const(
	cmd string = "\x1b["
	cmdReset string = cmd+"0m"
	cmdHighLight string = cmd + "1m"
	cmdSubline string = cmd + "4m"
	cmdBlink string = cmd + "5m"
	cmdInverse string = cmd + "7m"
	cmdInvisiable string = cmd + "8m"
	cmdClear string = cmd + "2J"//清屏
	cmdClearToLineEnd string = cmd + "K"//清除从光标到行尾的内容
	cmdPosSave string = cmd + "s"//保存光标位置
	cmdPosLoad string = cmd + "u"//恢复光标位置
	cmdHideCursor string = cmd + "?25l"//隐藏光标
	cmdShowCursor string = cmd + "?25h"//显示光标
)

func SetColor(f int, b int){
	SetFColor(f)
	SetBColor(b)
}

func SetFColor(index int){//0~7 黑红绿黄蓝紫青白
	fmt.Printf(cmd+"%dm",30+index)
}

func SetBColor(index int){
	fmt.Printf(cmd+"%dm",40+index)
}

func ExecCmd(cmdStr string){
	fmt.Printf(cmdStr)
}

func ClearColor(){
	ExecCmd(cmdReset)
}

func ClearScreen(){
	ExecCmd(cmdClear)
}

func movCmd(dir string, dis int) string {
	return fmt.Sprintf(cmd + "%d" + dir,dis)
}

func MovUp(dis int){//nA   光标上移n行
	ExecCmd(movCmd("A", dis))
}

func MovDown(dis int){//nB   光标下移n行
	ExecCmd(movCmd("B", dis))
}

func MovRight(dis int){//nC   光标右移n行
	ExecCmd(movCmd("C", dis))
}

func MovLeft(dis int){//nC   光标左移n行
	ExecCmd(movCmd("D", dis))
}

func SetPos(x int, y int){//[y;xH设置光标位置(现已很少使用)  
	ExecCmd(fmt.Sprintf(cmd + "%d;%dH",y,x))
}

func PutChar(c byte){
	fmt.Printf("%c",c)
}

func SetChar(x int, y int, data string){
	fmt.Printf(cmd + "%d;%dH" + data,y,x)
}