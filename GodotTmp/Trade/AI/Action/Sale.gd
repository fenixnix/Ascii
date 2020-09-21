static func Run(obj:Trader,env:TradeWorld):
	var site = obj.RndSelNearSite()
	print("sell")
	if site == null:
		yield()
		print("no site to Purchase")
		return
	obj.MoveTo(site)
	yield(obj,"arrive")
