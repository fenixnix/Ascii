import func
import json

siteUrl = "http://www.bachcentral.com/"
url = siteUrl + "midiindexcomplete.html"

soup = func.GetSoup(url)

skip_mark = "http://www.bachcentral.com/Organchorales/BSGJG_J.MID"
skip = True

midiList = []
for l in soup.find_all("a"):
    href = l.get("href")
    if href.endswith(".mid") or href.endswith(".MID"):
        link = siteUrl + href
        print(link)
        if skip:
            if link == skip_mark:
                skip = False
            else:
                continue
        midiList.append(link)
        func.DownLoad(link,"./midi/"+href.replace('/',"_"))