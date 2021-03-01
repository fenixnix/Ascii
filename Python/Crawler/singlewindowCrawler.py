import requests

User_Agent= [
	"Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; Win64; x64; Trident/5.0; .NET CLR 3.5.30729; .NET CLR 3.0.30729; .NET CLR 2.0.50727; Media Center PC 6.0)",
        "Mozilla/5.0 (compatible; MSIE 8.0; Windows NT 6.0; Trident/4.0; WOW64; Trident/4.0; SLCC2; .NET CLR 2.0.50727; .NET CLR 3.5.30729; .NET CLR 3.0.30729; .NET CLR 1.0.3705; .NET CLR 1.1.4322)",
        "Mozilla/4.0 (compatible; MSIE 7.0b; Windows NT 5.2; .NET CLR 1.1.4322; .NET CLR 2.0.50727; InfoPath.2; .NET CLR 3.0.04506.30)",
        "Mozilla/5.0 (Windows; U; Windows NT 5.1; zh-CN) AppleWebKit/523.15 (KHTML, like Gecko, Safari/419.3) Arora/0.3 (Change: 287 c9dfb30)",
        "Mozilla/5.0 (X11; U; Linux; en-US) AppleWebKit/527+ (KHTML, like Gecko, Safari/419.3) Arora/0.6",
        "Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.2pre) Gecko/20070215 K-Ninja/2.1.1",
        "Mozilla/5.0 (Windows; U; Windows NT 5.1; zh-CN; rv:1.9) Gecko/20080705 Firefox/3.0 Kapiko/3.0"
    ]                                #User_Agent的集合

headers={'User-Agent':'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3970.5 Safari/537.36'}
# headers= {'Accept': 'application/json, text/javascript, */*; q=0.01',
#            "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8",
#             "Accept-Encoding": "gzip, deflate",
#            "Accept-Language": "zh-CN,zh;q=0.9,en-US;q=0.8,en;q=0.7,zh-HK;q=0.6,zh-TW;q=0.5",
#           'Host': 'www.cninfo.com.cn',
#            'Origin': 'http://www.cninfo.com.cn',
#            'Referer': 'http://www.cninfo.com.cn/new/commonUrl?url=disclosure/list/notice',
#             'X-Requested-With': 'XMLHttpRequest'
#         }
verifyCode = "https://swapp.singlewindow.cn/qspserver/verifyCode/creator"
url = "https://swapp.singlewindow.cn/qspserver/sw/qsp/query/view/export?ngBasePath=https://swapp.singlewindow.cn:443/qspserver/"
ebl = "PASU5141340230"

html = requests.get(url,headers = headers).text

print(html)

index = 0

def getVerifyCode(url,path):
    r = requests.get(url,stream = True)
    with open("%s%s.gif"%(path,str(index)),"wb") as f:
        for chunk in r.iter_content(chunk_size=32):
            f.write(chunk)

for i in range(100):
    getVerifyCode(verifyCode,"./VerifyCode/")
    index += 1