extends RichTextLabel

func Set(dat):
	bbcode_enabled = true
	bbcode_text = """
	%s
	
		%s
"""%[
	dat.name,
	dat.desc
]
