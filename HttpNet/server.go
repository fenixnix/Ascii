package main
import (
    "fmt"
    "net/http"
    "strings"
	"log"
    "os"
    "text/template"
    "./page"
)

func ProcessMain(w http.ResponseWriter, r *http.Request) {
    r.ParseForm() //解析参数，默认是不会解析的
    fmt.Println(r.Form) //这些信息是输出到服务器端的打印信息
    fmt.Println("path", r.URL.Path)
    fmt.Println("scheme", r.URL.Scheme)
    fmt.Println(r.Form["url_long"])
    for k, v := range r.Form {
        fmt.Println("key:", k)
        fmt.Println("val:", strings.Join(v, ""))
    }
    tmpl,err := template.New("map").Parse(htmlText)
    if err != nil { panic(err) }
    tmpl.Execute(w,page.NewMainPage())
    //fmt.Fprintf(w, htmlText)
}

func ProcessGoodbye(w http.ResponseWriter, r *http.Request) {
    fmt.Printf("Request from:%s\n",r.RemoteAddr)
    r.ParseForm() //解析参数，默认是不会解析的
    fmt.Println(r.Form) //这些信息是输出到服务器端的打印信息
    fmt.Println("path", r.URL.Path)
    fmt.Println("scheme", r.URL.Scheme)
    fmt.Println(r.Form["url_long"])
    for k, v := range r.Form {
        fmt.Println("key:", k)
        fmt.Println("val:", strings.Join(v, ""))
    }
    fmt.Fprintf(w, "Good bye!\u2600\n\u2501\n") //这个写入到w的是输出到客户端的
}
func ProcessMap(w http.ResponseWriter, r *http.Request) {
    fmt.Printf("Request from:%s\n",r.RemoteAddr)
    r.ParseForm() //解析参数，默认是不会解析的
    fmt.Println(r.Form) //这些信息是输出到服务器端的打印信息
    fmt.Println("path", r.URL.Path)
    fmt.Println("scheme", r.URL.Scheme)
    fmt.Println(r.Form["url_long"])
    for k, v := range r.Form {
        fmt.Println("key:", k)
        fmt.Println("val:", strings.Join(v, ""))
    }
    tmpl,err := template.New("map").Parse(htmlMap)
    if err != nil { panic(err) }
    tmpl.Execute(w,page.NewMapPage())
}

var htmlText string
var htmlMap string

func main() {
    htmlText = LoadHTML("./page/main.html")
    htmlMap = LoadHTML("./page/map.html")

    http.HandleFunc("/", ProcessMain)//设置访问的路由
    http.HandleFunc("/goodbye", ProcessGoodbye) //设置访问的路由
    http.HandleFunc("/map",ProcessMap)
    err := http.ListenAndServe(":9090", nil) //设置监听的端口
    if err != nil {
        log.Fatal("ListenAndServe: ", err)
    }
}

func LoadHTML(path string)string{
    data:=make([]byte,1024)
	if file,err := os.Open(path);err==nil{
		defer file.Close()
		cnt,_:=file.Read(data)
		fmt.Printf("html:%s\n",htmlText)
		return (string)(data[:cnt])
	}else{
        log.Printf("File Open:%s",err.Error())
        return ""
	}	
}