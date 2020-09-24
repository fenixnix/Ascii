extends Node

func UseCardEfx(card):
	var sprite = Sprite.new()
	add_child(sprite)
	sprite.texture = GlbDb.CardImg(card.img)
	var tween = Tween.new()
	add_child(tween)
	tween.interpolate_property(sprite,"scale",Vector2.ONE*0.5,Vector2.ONE*1.3,1,Tween.TRANS_BACK,Tween.EASE_IN)
	tween.interpolate_property(sprite,"modulate",Color(1,1,1,1),Color(1,1,1,0),1,Tween.TRANS_BACK,Tween.EASE_IN)
	tween.start()
	yield(tween,"tween_all_completed")
	tween.queue_free()
	sprite.queue_free()
