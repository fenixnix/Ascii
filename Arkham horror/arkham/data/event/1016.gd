static func Use(chara:Chara,asset):
	var enms = []
	for enm in chara.location.enms:
		enms.append(enm.name)
	if len(enms)<=0:
		return false
	GlbUi.Select(enms)
	var index = yield(GlbUi,"select_option")
	chara.Attack(chara.location.enms[index],{"C":1,"dmg":1})
	asset.charge -= 1
	if asset.charge<=0:
		chara.assets.erase(asset)
	return true
