package tui
import(
	"fmt"
	"strings"
	tb"github.com/nsf/termbox-go"
	"github.com/mattn/go-runewidth"
)

const(
	checkMark = "\u2713"
	ballotX = "\u2717"
)

type TUI struct{
	lbFg,lbBg,btnFg,btnBg,btnHlFg,btnHlBg tb.Attribute
}

func NewTUI(lbF,lbB,btnF,btnB,btnHlF,btnHlB tb.Attribute)*TUI{
	return &TUI{
		lbFg:lbF,
		lbBg:lbB,
		btnFg:btnF,
		btnBg:btnB,
		btnHlFg:btnHlF,
		btnHlBg:btnHlB,
	}
}

func DrawBarVal(w int, title string, c int, m int){
	value := c*w/m
	blank := w - value
	fmt.Printf("%3s{%s%s",title,strings.Repeat("█",value),strings.Repeat("░",blank))
}

func BarValStr(w int, c int, m int)string{
	value := c*w/m
	blank := w - value
	return fmt.Sprintf("[%s%s]",strings.Repeat("|",value),strings.Repeat(".",blank))
}

func (t *TUI)PrintfBtn(x,y int,hl bool,msg string, a ...interface{}){
	var fg,bg tb.Attribute
	if hl{
		fg = t.btnHlFg
		bg = t.btnHlBg
	}else{
		fg = t.btnFg
		bg = t.btnBg	
	}
	tmp := fmt.Sprintf(msg,a...)
	for _, c := range tmp {
		tb.SetCell(x, y, c, fg, bg)
		x += runewidth.RuneWidth(c)
	}
}

func (t *TUI)Fill(x,y,w,h int, cell tb.Cell){
	for ly := 0; ly < h; ly++ {
		for lx := 0; lx < w; lx++ {
			tb.SetCell(x+lx, y+ly, cell.Ch, cell.Fg, cell.Bg)
		}
	}
}

func (t* TUI)DrawMenu(y,w int,m *Menu){
	for i,v := range m.menu{
		if i == m.cIndex{
			t.Printf(0,y+i,1,4,fmt.Sprintf("=[%2d # %-16s]=",i,v))
		}else{
			t.Printf(0,y+i,4,1,fmt.Sprintf(" [%2d # %-16s] ",i,v))
		}
	}
}

func (t* TUI)Box(x,y,w,h int,wire *Wire){
	var fg,bg tb.Attribute
	fg = tb.ColorWhite
	bg = tb.ColorBlack
	t.Printf(x,y,fg,bg,"%s",wire.Header(w))
	for row:=y+1;row<=y+h;row++{
		t.Printf(x,row,fg,bg,"%s",wire.Body(w))
	}
	t.Printf(x,y+h+1,fg,bg,"%s",wire.Feeter(w))
}
func (t *TUI)Printf(x,y int,fg,bg tb.Attribute, msg string, a ...interface{}){
	tmp := fmt.Sprintf(msg,a...)
	for _, c := range tmp {
		tb.SetCell(x, y, c, fg, bg)
		if IsFullwidth(c){
			x += 2
		}else{
			x++ 
		}
	}
}