import huobi.client.generic as hbgc
import huobi.client.market as hbmc
import huobi.constant
import huobi.utils
import requests
#AWS 云
AccessKey = "20ab2296-bgrdawsdsd-a0f615a4-862b2"
SecretKey = "00bf5302-ad997d66-568ac4af-338a3"

headers={'User-Agent':'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3970.5 Safari/537.36'}

# url = "wws://api-aws.huobi.pro"
# noMBP = "/ws"
# MBP = "/feed"
# BalanceOrder = "/ws/v1"

url = "https://api.huobi.pro"
apiUrl = url + "/v1/common/timestamp"
print(requests.get("https://www.google.com",headers = headers).text)
print(requests.get("https://www.baidu.com",headers = headers).text)
#print(requests.get(apiUrl,headers = headers).text)

generic_client = hbgc.GenericClient()
ts = generic_client.get_exchange_timestamp()
print(ts)

market_client = hbmc.MarketClient()
list_obj = market_client.get_candlestick('usdthusd',huobi.constant.CandlestickInterval.MIN5,10)
huobi.utils.LogInfo.output_list(list_obj)