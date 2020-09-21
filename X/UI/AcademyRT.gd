extends RichTextLabel

signal select(task)

func _ready():
	bbcode_enabled = true
	connect("meta_clicked",self,"on_select")

func Set(dat):
	bbcode_enabled = true
	clear()
	for t in dat.get("task",[]):
		var txt = """
Training %s
%s %2d%%
"""%[
			GlbDb.cls_dict[t.item.id],
			BBCode.bar_full(t.progress,64),
			floor(t.progress*100)
		]
		push_meta(t)
		append_bbcode(txt)
		pop()

func on_select(meta):
	emit_signal("select",meta)
