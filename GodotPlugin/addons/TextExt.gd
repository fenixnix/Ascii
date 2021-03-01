class_name TextExt

static func parseValue(txt):
	match txt:
		"true":return true
		"false":return false
		_:return int(txt)
	return null

static func removal(txt,marks = ['{','}']):
	var tmp = ""
	var queue = 0
	for t in txt:
		if t == marks[1]:
			queue -= 1
			continue
		if t == marks[0]:
			queue += 1
			continue
		if queue>0:
			tmp += t
	return tmp
