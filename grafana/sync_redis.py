import redis
import json

def TxsCount(block):
    txc = 0
    for d in block:
        dat = bytes.decode(d)
        js = json.loads(dat)
        txs = js['transCount']
        txc += txs
        print(txs)
    return txc

r = redis.StrictRedis(host="192.168.1.241",port=6379,db=0)
lst = r.lrange('3',0,-1)
print(TxsCount(lst))
data = bytes.decode(lst[0])
js = json.loads(data)
#print(js['transCount'])
#for l in lst:
    #print(l)