package jdat

import (
	"time"
	"math/big"
	//"cmd/go/internal/str"
)

type config struct{
	Name string
	Hash string
	Level int
	Exp *big.Int
	Lst []string
	Data Chain
}

type Complex struct{
	Dats map[string]config
}

type Chain struct{
	Parent string
	Number int
	T time.Time
}