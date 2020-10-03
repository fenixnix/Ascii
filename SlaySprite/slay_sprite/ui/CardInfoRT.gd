extends RichTextLabel

func Set(card_info):
	bbcode_enabled = true
	bbcode_text = """
	%s Cost%s Rarity %s:
	%s
	"""%[
		card_info.name,
		str(card_info.cost),
		card_info.rarity,
		str(card_info)
	]
