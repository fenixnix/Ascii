extends RichTextLabel

func Set(chara):
	bbcode_enabled = true
	bbcode_text = """EN:%d/%d BLK %d HP:%d/%d
"""%[
	chara.en,chara.chara.en,
	chara.blk,
	chara.chara.hp,chara.chara.mhp,
]
