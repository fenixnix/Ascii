extends RichTextLabel

func Set(dat):
	bbcode_enabled = true
	bbcode_text = """%s
BLK %d HP %d/%d
attr:%s
status:%s
	"""%[
		dat.data.name,
		dat.blk,dat.hp,dat.mhp,
		dict_code(dat.attr),
		dict_code(dat.status)
	]

func dict_code(dict):
	var tmp = ""
	for key in dict.keys():
		tmp += "[%s:%d]"%[key,dict[key]]
	return tmp
