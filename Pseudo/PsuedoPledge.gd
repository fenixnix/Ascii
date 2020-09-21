#http://192.168.100.202/chen.gang/staking/tree/master
#http://192.168.100.202/ liu.yanbin pwd:common
extends Node

var cacheData = {}
var cacheFile = "user://cache.json"

func _ready():
	var tmp = FileRW.LoadJsonFile(cacheFile)
	if tmp == null:
		return
	cacheData = tmp
	$GUI/HttpURL.text = cacheData.get("url","http://localhost:8001")

func _on_HTTPRequest_rcv_data(dat):
	$GUI/Msg.clear()
	$GUI/Msg.add_text(dat)

func Post(data):
	$HTTPRequest.Post($GUI/HttpURL.text,data)

func _on_Pledge_pressed():
	var data = {
		"cmd":"pledge",
		"varl":$GUI/Menu/Validator.text,
		"deleg":$GUI/Menu/Delegator.text,
		"wht":$GUI/Menu/balance.value,
		}
	Post(data)

func _on_UnPledge_pressed():
	var data = {
		"cmd":"unpledge",
		"varl":$GUI/Menu/Validator.text,
		"deleg":$GUI/Menu/Delegator.text,
		"wht":$GUI/Menu/balance.value,
		"time":$GUI/Menu/Epoch.value,
	}
	Post(data)

func _on_Query_pressed():
	var data = {
		"cmd":"query",
		"deleg":$GUI/Menu/Delegator.text,
	}
	Post(data)

func _on_AddEpoch_pressed():
	var data = {
		"cmd":"epoch",
		"val":$GUI/Menu/Epoch.value,
	}
	Post(data)

func _on_IsMain_pressed():
	var data = {
		"cmd":"is_main",
		"addr":$GUI/Menu2/Addr.text,
	}
	Post(data)

func _on_ShardID_pressed():
	var data = {
		"cmd":"shard_id",
		"addr":$GUI/Menu2/Addr.text,
	}
	Post(data)

func _on_GetSubList_pressed():
	var data = {
		"cmd":"sub_list",
	}
	Post(data)

func _on_ShardList_pressed():
	var data = {
		"cmd":"shard_list",
		"id":$GUI/Menu2/HBoxContainer/ID.value
	}
	Post(data)

func _on_GetMainList_pressed():
	var data = {
		"cmd":"main_list",
	}
	Post(data)

func _on_HttpURL_text_entered(new_text):
	cacheData["url"] = new_text
	FileRW.SaveJsonFile(cacheFile,cacheData)

func _on_SetValidators_pressed():
	var validatorSettingUI = load("res://ValidatorSetting.tscn")
	var ui = validatorSettingUI.instance()
	add_child(ui)
	var dat = yield(ui,"set_validators")
	var varl = JSON.print(dat)
	print(varl)
	var data = {
		"cmd":"set_validators",
		"varl":varl,
	}
	Post(data)
