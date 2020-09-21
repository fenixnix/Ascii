package main

import (
	"fmt"
	"bufio"
	"os"
	"io"
	"regexp"
	"strconv"
	"log"
	"net/http"
	_"net/http/pprof"
)

const dbFile = "./indexDB"
var codeIndex []string

//SetMap unicode set info
type SetMap struct{
	start,cnt int
	key,desc string
}

func (s *SetMap) end()int{
	return s.start + s.cnt
}

var table []SetMap

func initDB(){
	file,err:=os.OpenFile(dbFile,os.O_CREATE|os.O_RDONLY,0644)
	if err != nil{return}
	defer file.Close()
	reader := bufio.NewReader(file)
	index := 0
	table = make([]SetMap,0)
	for{
		line,_,err:=reader.ReadLine()
		if err == io.EOF{break}
		if err!=nil{continue}
		//fmt.Printf("%3d:%s\n",index,string(line))
		startIndexStr := regexp.MustCompile("^.+-").FindString(string(line))[:4]
		endIndexStr := regexp.MustCompile("-.+：").FindString(string(line))[1:5]
		desc := regexp.MustCompile(`：.* \(`).FindString(string(line))
		key := regexp.MustCompile(`\(.*\)`).FindString(string(line))
		starti,_:=strconv.ParseInt(startIndexStr,16,32)
		endi,_:=strconv.ParseInt(endIndexStr,16,32)
		if len(key) == 0{
			key = regexp.MustCompile(`：.*$`).FindString(string(line))[len("："):]
		}else{
			key = key[1:len(key)-1]
		}
		if desc!=""{
			desc = desc[len("："):len(desc)-1]
		}
		//fmt.Printf("#%3d %4x-%4x Key:%s | %s\n",index,starti,endi,key,desc)
		table = append(table,SetMap{
			start:int(starti),
			cnt:int(endi-starti+1),
			key:key,
			desc:desc,
		})
		index++
	}
	fmt.Println("view table")
	for i,v := range table{
		fmt.Printf("#%3d %4x:%5d %-40s\n",i,v.start,v.cnt,v.key)
	}
	fmt.Printf("\n")
}

func main(){
	go func(){
		log.Println(http.ListenAndServe("localhost:6060",nil))
	}()
	initDB()
	for{
		fmt.Printf("CMD: print, ls, quit\n-->:")
		var cmd string
		cnt,err := fmt.Scanf("%s\n",&cmd)
		if err==nil{
			if cnt>0{
				switch cmd {
				case "print": 
				var index int
				fmt.Printf("input char index with HEX:\n-->:")
				fmt.Scanf("%x\n",&index)
				fmt.Printf("#%4X : %-3c\n",index,index)
				case "ls": 
				var ls int
				fmt.Printf("input ls index:\n-->:")
				fmt.Scanf("%d\n",&ls)
				if ls<len(table){
					PrintSet(ls)
				}else{
					fmt.Printf("Out of Range!!\nRange: 0 ~ %d\n",len(table)-1)
				}
				case "exit": return
				case "quit": return
				default:
				}
			}
		}
	}
}

//PrintSet Print Unicode Set
func PrintSet(index int){
	set:=table[index]
	PrintUnicode(set.start,set.cnt)
	fmt.Printf("#%3d %4X~%4X %s %s\n",index,set.start,set.end(),set.key,set.desc)
}

//PrintUnicode Print Unicode from start code with row*8
func PrintUnicode(start,cnt int){
	for index := 0; index < cnt; index++ {
		c := start + index
		fmt.Printf("%4X %-3c ",c,c)
		if index%8 == 7{
			fmt.Printf("\n")
		}
	}
	fmt.Printf("\n")
}