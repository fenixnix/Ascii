from selenium import webdriver
from bs4 import BeautifulSoup
import time
import json
import os
import re
import requests

savePath = "G:/Nix/PDF/"

chrome_options = webdriver.ChromeOptions()
#chrome_options.add_argument('--headless')
#chrome_options.add_argument('--disable-gpu')
driver = webdriver.Chrome(chrome_options = chrome_options)

def download(url,fileName):
    f=requests.get(url)
    with open(fileName,'wb') as dat:
        dat.write(f.content)

def process_page(link,fileName):
    driver.get(link)
    time.sleep(1)
    #get pdf url
    html = BeautifulSoup(driver.page_source,'lxml')
    print(fileName)
    pdf = html.find('embed',class_="pdfobject")
    if pdf is None:
        print(html,"html error!!!")
        return
    m = re.search(r'.*PDF',pdf["src"])
    pdfUrl = m.group()
    #fileName = re.search(r'[0-9]*\.PDF',pdfUrl).group()
    download(pdfUrl,savePath +fileName.replace('*','+'))

jsonStr = '' 
with open('annLst.json','r') as f:
    jsonStr = f.read()
annLst = json.loads(jsonStr)
for ann in annLst:
    link = ann['url']
    fileName = "[%s](%s)%s.pdf"%(ann['code'],ann['name'],ann['title'])
    process_page(link,fileName)

driver.close()
