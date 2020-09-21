extends HTTPRequest

signal rcv_data(dat)

func _ready():
	connect("request_completed",self,"_on_request_completed")

func Get(url):
	var headers = ["Content-Type: application/json"]
	request(url,headers,false)

func Post(url, data_to_send, use_ssl = false):
	var query = JSON.print(data_to_send)
	var headers = ["Content-Type: application/json"]
	request(url, headers, use_ssl, HTTPClient.METHOD_POST, query)

func _on_request_completed(result,response_code,headers,body):
	emit_signal("rcv_data",body.get_string_from_utf8())
