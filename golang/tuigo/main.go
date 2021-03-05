package main
import "github.com/marcusolsson/tui-go"
func InitUI()tui.Widget{
	box := tui.NewVBox(
		tui.NewLabel("tui-go"),
		tui.NewLabel("label1"),
		tui.NewLabel("label1"),
		tui.NewLabel("label1"),
		tui.NewLabel("label1"),
		tui.NewLabel("label1"),
		tui.NewButton("label1"),
	)
	return box
}
func main(){
	widget := InitUI()
	ui, err := tui.New(widget)
	if err != nil {
		panic(err)
	}
	ui.SetKeybinding("Esc", func() { ui.Quit() })
	if err := ui.Run(); err != nil {
		panic(err)
	}
}