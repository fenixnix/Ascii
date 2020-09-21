package game

type State interface{
	Rcv(msg int)
	Enter()
	Back()
	Render()
}

type StateStack struct{
	states []State
}

func NewStateStack()StateStack{
	return StateStack{
		states : make([]State,0),
	}
}

func (s*StateStack) Push(state State){
	s.states = append(s.states,state)	
}

func (s*StateStack) Switch(state State){
	length := len(s.states)
	if length==0{return}
	s.states[length-1]=state
}
func (s*StateStack) Pop(){
	length := len(s.states)
	if length<=1{return}
	s.states = s.states[:length-1]
	s.Top().Enter()
}

func (s*StateStack) Top()State{
	length := len(s.states)
	if length >0{
		return s.states[length-1]
	}
	return nil
}