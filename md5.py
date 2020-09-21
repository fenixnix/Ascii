import os
import hashlib

str = "hello"
m = hashlib.md5(str.encode(encoding = "utf-8"))
#m.update("hello world")
md5 = m.hexdigest()
print(md5)