package page

type MapPage struct{
	Site string
	Menu []string
}
func NewMapPage()MapPage{
	return MapPage{
		Site:"Village",
		Menu:[]string{"Forest","Ruin"},
	}
}
type MainPage struct{
	Menu []string
}

func NewMainPage()MainPage{
	return MainPage{
		Menu:[]string{"NEW","LOAD","EXIT"},
	}
}