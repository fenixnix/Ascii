package bcm

import "testing"

const checkMark = "\u2713"
const ballotX = "\u2717"

func Test(t *testing.T){
	InitBCM(&TMnt{})
	Wait()
}