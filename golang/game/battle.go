package game

import(
	"fmt"
	"sort"
	"sync"
	"time"
)
type Battle struct{
	PC Battlers
	NPC Battlers
	ALL Battlers
	current *Battler
	running bool
	win bool
	wg sync.WaitGroup
}

func NewBattle(pc,npc Battlers)*Battle{
	fmt.Printf("Init Btl PC:%d,NPC:%d\n",len(pc),len(npc))
	tmp := Battle{
		running : true,
		win : false,
		ALL:append(pc,npc...),
	}
	tmp.UpdateTeam()
	tmp.wg.Add(1)
	go tmp.loop()

	return &tmp
}

func (b *Battle) UpdateTeam(){
	b.PC = Battlers{}
	b.NPC = Battlers{}
	for i,v := range b.ALL{
		if v.dead{
			continue
		}
		fmt.Printf("Insert Btl:%s team:%d",v.Name,v.Team)
		if(v.Team == 0){
			b.PC.Append(b.ALL[i])
		}else{
			b.NPC.Append(b.ALL[i])
		}
	}
}

func (b *Battle) Tick(){
	sort.Sort(b.ALL)
	b.UpdateTeam()
	if b.NPC.Len() == 0{
		b.win = true
	}
	if b.PC.Len() == 0 || b.NPC.Len() == 0{
		b.running = false
		return
	}

	fmt.Printf("---Round---\n");
	for _,v := range b.ALL{
		b.current = v
		fmt.Printf("%s",v.Print())
		if v.Team == 0{
			//Print GUI
			//WaitInput
			for _,t := range b.NPC.RndSel(){
				v.Attack(t)
			}
		}else{
			for _,t := range b.PC.RndSel(){
				v.Attack(t)
			}
		}
	}
	time.Sleep(2*time.Second)
}

func (b *Battle) loop(){
	defer b.wg.Done()
	for{
		b.Tick()
		if !b.running{
			break;
		}
	}
}