import requests
import re
from bs4 import BeautifulSoup
import func

#pic,novel

#headers={'User-Agent':'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.110 Safari/537.36'}
headers={'User-Agent':'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3970.5 Safari/537.36'}
url = "https://c1.fusz.xyz/thread0806.php?fid=2"

def DownLoadImageOnPage(_url):
    soup = func.GetSoup(_url)
    imgs = soup.find_all('img',attrs = {'data-link' : True})
    #imgs = soup.find_all('div',attrs = {'class' : 'image-big-text'})
    for i in imgs:
        #print(i)
        link = i["data-link"]
        print(link)
        file = link.split('/')[-1]
        func.DownLoad(link,'./img/'+file)

def RmDown(_url):
    soup = func.GetSoup(_url)
    li = soup.find_all("li")
    print(li)

def GetPost(pageUrl):
    tmp = []
    soup = func.GetSoup(pageUrl)
    lst = soup.body.find_all(target="_blank")
    t = 0
    for l in lst:
        if t%2 == 0 and "htm_data" in l["href"]:
            tmp.append(l["href"])
        t+=1
    return tmp

def GetLink(postUrl):
    print(postUrl)
    tmp = []
    soup = func.GetSoup(postUrl)
    links = soup.body.find_all('a',target='_blank')
    for l in links:
        if "rmdown" in l.text:
            tmp.append(l.string)
    return tmp

#lst = GetPost(url)
#for l in lst:
#GetLink("https://c1.fusz.xyz/htm_data/2005/2/3933302.html")
#RmDown("http://www.rmdown.com/link.php?hash=202d4941fe4557fe6a2155230ff68ebc6a24354f8b4")
DownLoadImageOnPage('https://c1.fusz.xyz/htm_data/2005/8/3932758.html')