from selenium import webdriver
from bs4 import BeautifulSoup
import time
import json
import os
import string

mainUrl = "http://www.cninfo.com.cn"
urls = [
    "http://www.cninfo.com.cn/new/commonUrl?url=disclosure/list/notice#sse",
    "http://www.cninfo.com.cn/new/commonUrl?url=disclosure/list/notice#szse"
]

chrome_options = webdriver.ChromeOptions()
chrome_options.add_argument('--headless')
chrome_options.add_argument('--disable-gpu')
driver = webdriver.Chrome(chrome_options = chrome_options)

announcementList = []

def GetPageCount(source):
    html = BeautifulSoup(driver.page_source,'lxml')
    numbers = html.find_all('li',class_='number')
    max = 0
    for n in numbers:
        val = int(n.string)
        if val>max:
            max = val
    return max

def ReadPage():
    html = BeautifulSoup(driver.page_source,'lxml')
    res = html.find_all('tr',class_="el-table__row")
    for r in res:
        subHtml = BeautifulSoup(str(r),'lxml')
        data = {}
        data["code"] = subHtml.find('td',class_="el-table_1_column_1").text
        data["name"] = subHtml.find('td',class_="el-table_1_column_2").text
        data["title"] = subHtml.find('td',class_="el-table_1_column_3").div.a.text.strip()
        data["url"] = mainUrl+subHtml.find('td',class_="el-table_1_column_3").div.a['href']
        print("[%s]%s:%s\n:->%s"%(data["code"],data["name"],data["title"],data["url"]))
        announcementList.append(data)


def ReadBlock(url):
    driver.get(url)
    time.sleep(2)
    cnt = GetPageCount(driver.page_source)
    #page loop
    for i in range(cnt):
        #NextPage
        ReadPage()
        driver.find_element_by_class_name("btn-next").click()
        time.sleep(2)

for u in urls:
    ReadBlock(u)

#save to json
jsonStr = json.dumps(announcementList)
with open("annLst.json",'w') as f:
    f.write(jsonStr)

driver.quit()
