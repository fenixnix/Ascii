extends HBoxContainer

var data

func Set(ect):
	data = ect
	for act in data.act:
		print(act.name)
		$act.Append(GlbDb.CardImg(act.img))
		$act.Append(GlbDb.CardImg(act.imgb))
	for agenda in data.agenda:
		print(agenda.name)
		$agenda.Append(GlbDb.CardImg(agenda.img))
		$agenda.Append(GlbDb.CardImg(agenda.imgb))

