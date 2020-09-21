static func Run(obj:Trader,env:TradeWorld):
	var site = obj.RndSelNearSite()
	print("buy")
	if site == null:
		yield()
		print("no site to Purchase")
		return
	obj.MoveTo(site)
	yield(obj,"arrive")
	obj.Buy(site,0)
	
