static func Use(chara:Chara,asset):
	asset.charge -= 1
	var shroud = chara.location.shroud
	chara.location.shroud -= 2
	GlbDat.Scan()
	chara.location.shroud = shroud
	if asset.charge<=0:
		chara.assets.erase(asset)
