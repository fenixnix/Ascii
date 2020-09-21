package tui

type TUIGame interface {
	Init()
	InputUpdate()bool
	Update()
	RenderUpdate()
}
