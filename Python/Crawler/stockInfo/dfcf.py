from selenium import webdriver
from bs4 import BeautifulSoup
import time
import json
import os
import string

url_base = "http://guba.eastmoney.com/"
url = "http://guba.eastmoney.com/default,3_1.html"

chrome_options = webdriver.ChromeOptions()
chrome_options.add_argument('--headless')
chrome_options.add_argument('--disable-gpu')
driver = webdriver.Chrome(chrome_options = chrome_options)

driver.get(url)
time.sleep(2)
#print(driver.page_source)
html = BeautifulSoup(driver.page_source,'lxml')
ress = html.find_all("a",class_="note")
pages = html.find_all("a",string = "下一页")
for res in ress:
    print(res)

