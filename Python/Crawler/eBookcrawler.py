import gutenberg
import func

#url = 'http://www.cntour.cn/'
#url = 'https://www.gcores.com/articles'
#url = 'https://opengameart.org/'
url = 'http://www.gutenberg.org/wiki/Children%27s_Fiction_(Bookshelf)'

bookUrl = 'https://www.gutenberg.org/ebooks/22224.kindle.images'
#bookUrl = 'https://www.gutenberg.org/ebooks/22224.txt.utf-8'

pages = gutenberg.GetBookPages(url)
for p in pages:
    files = gutenberg.DownloadBookOnPage("http:"+p)
