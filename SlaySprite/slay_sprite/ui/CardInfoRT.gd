extends RichTextLabel

func Set(card_info):
	bbcode_enabled = true
	bbcode_text = """
	%s Cost%s Rarity %s:
	%s
	"""%[
		card_info.name,
		str(card_info.get("cost",0)),
		card_info.get("rarity","Common"),
		str(card_info)
	]
