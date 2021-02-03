extends Node

class_name ComFun

static func ModDict(org,src):
	for k in src:
		if org.has(k):
			org[k] += float(src[k])
		else:
			org[k] = float(src[k])

static func ModDictKey(src,modDict):
	for m in modDict:
		if src.has(m):
			src[modDict[m]] = src[m]
			src.erase(m)
	return src

static func AddDictTag(dict,key,val):
	for d in dict.values():
		d[key] = val


