package main
import "github.com/gocolly/colly"
import (
	"fmt"
	"os"
	"bytes"
	"io/ioutil"
	"io"
	"net/http"
	"strings"
)

var(
	crawlerUrl string = "roguebasin.com"
)

func main() {
	for index := 0; index < 5000; index++ {
		url := fmt.Sprintf("http://www.scp-wiki.net/scp-%03d",index)
		SavHtml(url)
	}
}

func MangaFetch(){
	c := colly.NewCollector(
		//colly.AllowedDomains(crawlerUrl),
	)
	
	c.OnHTML("div[id]",func(e *colly.HTMLElement){
		if e.Attr("id") == "comic"{
			url:=e.ChildAttr("img[src]","src")
			fmt.Printf("P:%v\n",url)
			SavImg("http:"+url)
		}
	})

	// Find and visit all links
	c.OnHTML("a[href]", func(e *colly.HTMLElement) {
		link := e.Attr("href")

		if(e.Attr("rel")=="prev"){
			e.Request.Visit(e.Request.AbsoluteURL(link))
		}
		//url:=e.Request.AbsoluteURL(link)
		//fmt.Printf("Text:%s\nLink:%s\n",e.Text,url);
	})


	c.OnRequest(func(r *colly.Request) {
		fmt.Println("Visiting", r.URL)
	})

	c.Visit("http://xkcd.com/")
	//c.Visit("http://m.ikkdm.com/")
	//c.Visit("http://www.roguebasin.com/index.php?title=Articles")
}

func SavImg(url string) (n int64, err error) {
	path := strings.Split(url, "/")
	var name string
	if len(path) > 1 {
		name = path[len(path)-1]
	}
	fmt.Println(name)
	out, err := os.Create(name)
	defer out.Close()
	if resp, err := http.Get(url);err ==nil{
		defer resp.Body.Close()
		pix, _ := ioutil.ReadAll(resp.Body)
		n, err = io.Copy(out, bytes.NewReader(pix))
	}else{
		fmt.Printf("%s\n",err.Error())
	}
	return
}

func SavHtml(url string){
	path := strings.Split(url, "/")
	var name string
	if len(path) > 1 {
		name = path[len(path)-1]
	}
	fmt.Println(name)
	out, _ := os.Create(name)
	defer out.Close()
	if resp, err := http.Get(url);err ==nil{
		defer resp.Body.Close()
		pix, _ := ioutil.ReadAll(resp.Body)
		_, err = io.Copy(out, bytes.NewReader(pix))
	}else{
		fmt.Printf("%s\n",err.Error())
	}
	return
}