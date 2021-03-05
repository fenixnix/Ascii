package bcm

type TMnt struct{}

func(m *TMnt) Process(cmd string)string{
	switch(cmd){
	case "1":
		return "a"
	case "2":
		return "b"
	case "3":
		return "C"
	case "块":
		return "区块高度"
	default:
		return "unknow command！"
	}
}