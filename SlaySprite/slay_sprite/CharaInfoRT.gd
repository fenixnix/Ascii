extends RichTextLabel

func Set(chara):
	bbcode_enabled = true
	bbcode_text = """EN:%d/%d BLK %d HP:%d/%d
attr:%s
status:%s
power:%s
hand:%d
"""%[
	chara.en,chara.chara.en,
	chara.blk,
	chara.chara.hp,chara.chara.mhp,
	dict_code(chara.attr),
	dict_code(chara.status),
	dict_code(chara.power),
	len(chara.hand)
]

func dict_code(dict):
	var tmp = ""
	for key in dict.keys():
		tmp += "[%s:%d]"%[key,dict[key]]
	return tmp
