extends RichTextLabel

var txt_length = 0
var msgQueue = []

func _init():
	bbcode_enabled = true
	txt_length = 0
	visible_characters = 0

func Text(msg):
	msgQueue.append({"type":"text","msg":msg})

func Title(msg):
	msgQueue.append({"type":"title","msg":msg})

func anim(cnt,spd=0.03):
	$Tween.interpolate_property(self,"visible_characters",txt_length,txt_length+cnt,cnt*spd,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
	$Tween.start()
	txt_length += cnt

func text(msg):
	bbcode_text += "\t"+msg+"\n"
	anim(len(msg)+2)
	newline()

func title(msg):
	bbcode_text += "\n[center][color=#808080][font=res://font/desc.tres]%s[/font][/color][/center]\n\n"%msg
	anim(len(msg)+1)
	newline()

var running = false
func _physics_process(delta):
	if !running && len(msgQueue):
		running = true
		var res = msgQueue.pop_front()
		match res.type:
			"title":title(res.msg)
			"text":text(res.msg)
		yield($Tween,"tween_all_completed")
		running = false
