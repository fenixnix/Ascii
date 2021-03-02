import huobi
#AWS 云
AccessKey = ""
SecretKey = ""

url = "wws://api.huobi.pro"
url = "wws://api-aws.huobi.pro"
noMBP = "/ws"
MBP = "/feed"
BalanceOrder = "/ws/v1"

generic_client = GenericClient()
ts = generic_client.get_exchange_timestamp()
print(timestamp)

market_client = MarketClient()
list_obj = market_client.get_candlestick('btcusdt',CandlestickInterval.MIN5,10)
LogInfo.output_list(list_obj)