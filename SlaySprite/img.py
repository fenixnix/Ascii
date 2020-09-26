import requests

root_url = "https://static.wikia.nocookie.net/slay-the-spire/"
image_path = "./slay_sprite/image/%s"
reg_filter = "images/[0-9,a-z]/[0-9,a-z].{1,20}png"

def download(url,file):
    r = requests.get(url) 
    if r.status_code!=200:
        return False
    with open(file, "wb") as f:
        f.write(r.content)
    return True

new_list = []

with open("url.txt",'r',encoding='UTF-8') as f:
    preview = ""
    while True:
        line = f.readline()
        if not line:
            break
        if line!=preview:
            preview = line
            new_list.append(line)

print(new_list)
for f in new_list:
    pair = f.rsplit('/',1)
    img_url = (root_url + f).strip()
    img_file = image_path%pair[1]
    print(img_url,img_file)
    download(img_url,img_file)
    