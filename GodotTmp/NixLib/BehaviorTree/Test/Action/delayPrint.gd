static func Run(obj,env):
	var time = Timer.new()
	time.start(3)
	obj.add_child(time)
	yield(time,"timeout")
	print("leaf action")
	time.queue_free()
