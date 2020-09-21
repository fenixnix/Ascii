static func PickUp(owner):
	for c in owner.get_children():
		if c is UnitLife:
			c.Add(1)
