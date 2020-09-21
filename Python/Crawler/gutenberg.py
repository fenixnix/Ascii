import requests
import re
import time
import func
from bs4 import BeautifulSoup

headers={'User-Agent':'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.110 Safari/537.36'}

url = 'http://www.gutenberg.org/wiki/Children%27s_Fiction_(Bookshelf)'

def DownloadBookOnPage(_url):
    print(_url)
    files = []
    html = requests.get(_url,headers = headers)
    soup = BeautifulSoup(html.text,'lxml')
    links = soup.find_all(about=True)
    for l in links:
        file = l["about"]
        if re.match("https",file):
            saveFile = file.split('/')[-1] + ".mobi"
            if 'kindle' in file:
                print(file,saveFile)
                func.DownLoad(file,"./Books/"+saveFile)
            files.append(file)
    return files

def GetBookPages(url):
    tmp = []
    strhtml = requests.get(url,headers = headers)
    soup = BeautifulSoup(strhtml.text,'lxml')
    data = soup.find_all("li")
    for d in data:
        href = d.a
        if href!=None:
            href = href["href"]
            if href!=None:
                #print(href)
                link = re.match("//www",href)
                if link != None:
                    tmp.append(href)
    return tmp
