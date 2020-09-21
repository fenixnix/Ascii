extends RichTextLabel

func Set(dat):
	bbcode_enabled = true
	bbcode_text = BBCode.site(dat)
	BBCode.fleets(self,dat.fleets)
