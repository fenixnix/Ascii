from huobi.client.generic import GenericClient
import huobi.constant
import huobi.utils
import json

AccessKey = "20ab2296-bgrdawsdsd-a0f615a4-862b2"
SecretKey = "00bf5302-ad997d66-568ac4af-338a3"

generic_client = GenericClient()
print(generic_client.get_market_status())
info = {
#     "timestamp":generic_client.get_exchange_timestamp(),
#     "system_status":generic_client.get_system_status(),
#     "info":generic_client.get_exchange_info(),
#     "market_status":generic_client.get_market_status(),
#     "currencies":generic_client.get_exchange_currencies(),
#     "symbols":generic_client.get_exchange_symbols()
}

print(info)
with open("huobi_info",'w') as f:
    f.write(json.dumps(info))