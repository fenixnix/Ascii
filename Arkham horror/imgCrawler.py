import requests

dbUrl = "https://arkhamdb.com"
cardUrl = "/bundles/cards/"

dstPath = "./image/card/"

def download(url,file):
    r = requests.get(url) 
    if r.status_code!=200:
        return False
    with open(file, "wb") as f:
        f.write(r.content)
    return True

def grab(set,index):
    GrabByName("%02d%03d"%(set,index+1))

def GrabByName(_fileName):
    fileName = "%s.png"%(_fileName)
    url = dbUrl + cardUrl + fileName
    dst = dstPath + fileName
    res = download(url,dst)
    if res:
        print(url,dst)
    else:
        fileName2 = "%s.jpg"%(_fileName)
        url = dbUrl + cardUrl + fileName2
        dst = dstPath + fileName2
        download(url,dst)
        print(url,dst)

setCnt = [182,333,355,350,352,354,23,279,137,248,19,14]

def crawler():
    for i in range(1,12):
        for j in range(setCnt[i]):
            grab(i+1,j)

# #crawler()
# grabByName("01001b")
# grabByName("01002b")
# grabByName("01003b")
# grabByName("01004b")
# grabByName("01005b")

