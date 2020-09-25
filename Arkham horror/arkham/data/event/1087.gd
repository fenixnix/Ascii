static func Use(chara,asset):
	asset.charge -= 1
	var shroud = chara.loc.shroud
	chara.loc.shroud -= 2
	GlbDat.Scan()
	chara.loc.shroud = shroud
	if asset.charge<=0:
		chara.assets.erase(asset)
