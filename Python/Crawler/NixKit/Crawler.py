import json
import requests
from bs4 import BeautifulSoup as bs
from selenium import webdriver

headers={'User-Agent':'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3970.5 Safari/537.36'}
#headers={'User-Agent':'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.110 Safari/537.36'}
image_url = "https://www.python.org/static/community_logos/python-logo-master-v3-TM.png"

def GetSoup(url):
    soup = bs(GetWeb(url),'lxml')
    return soup

def GetWeb(url):
    return requests.get(url,headers = headers).text

def DownLoad(url,file):
    r = requests.get(url,headers)
    #print(r.headers)
    with open(file,'wb') as f:
        f.write(r.content)

import urllib.request
def DownLoad2(url,file):
    response = urllib.request.urlopen(url)
    cat_img = response.read()
    with open(file,'wb') as f:
        f.write(cat_img)

def DownLoad3(url,file):
    urllib.request.urlretrieve(url , filename=file)

def SaveText(text,file):
    with open(file,'w') as f:
        f.write(text)

def SaveWeb(url,file):
    SaveText(GetWeb(url),file)