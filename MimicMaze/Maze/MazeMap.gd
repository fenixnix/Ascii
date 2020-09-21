extends Node

var maze:Maze3D = null
var objs:Grid = null
var fog:Grid = null

var tmpDat = {}
var dfs

var startTime = 0
var endTime = 0
var countTime = false

export(Array,PackedScene) var mazeObjPrefab

onready var timeLabel = $HUD/Root/Time
onready var msgDlg = $HUD/MessageDlg
onready var cam = $Camera2D

func _ready():
	GlbAudio.PlayBGM("res://Audio/zero-project-zero-project_-_02_-_Moon_waltz.ogg")
	msgDlg.hide()
	$DrawMaze.avatar = $Avatar
	randomize()
	NewGame({"algorithm":0, "cam_follow":false, "d":1, "enemy":false, "fog":false, "food":false, "h":4, "w":4, "zoom":1, "mode":0})

func NewGame(dat):
	msgDlg.hide()
	print(dat)
	tmpDat = dat
	var w = dat.w
	var h = dat.h
	var d = dat.get("d",1)
	
	objs = Grid.new([w,h,d])
	
	#Init Fog
	if dat.get("fog",false):
		fog = Grid.new([w,h,d])
		fog.Fill(true)

	#Setup Camera
	if dat.get("cam_follow",false):
		cam.smoothing_enabled = true
		cam.zoom = Vector2.ONE*dat.get("zoom",1)
		SetCam($Avatar)
	else:
		cam.position = Vector2(w,h)*MazeDefine.gridSize/2
		#cam.position = Vector2.ZERO
		cam.zoom = Vector2.ONE*(max(w,max(h,d))*MazeDefine.gridSize/get_viewport().size.y)
		SetCam(self)

	maze = Maze3D.new([w,h,d])
	var start = maze.RndIndex()
	var startLoc = maze.GetLoc(start)
	match dat.get("algorithm",0):
		0:
			dfs = DepthFirst3D.new()
			#maze = dfs.init([startLoc[0],startLoc[1],0],[w,h,d])
			maze = dfs.Gen([startLoc[0],startLoc[1],0],[w,h,d])
		1:
			var prim = Prim3D.new()
			maze = prim.Gen([startLoc[0],startLoc[1],d],[w,h,d])
	maze.Print()

	var endPoints = maze.GetAllDeadEnds()
	var crossPoints = maze.GetAllCrossPoints()


	var astar = AStarGrid3D.new(maze)
	var end = astar.CalcDepthestPathFromStart(start,endPoints)

	var width:int = maze.size[0]
	$Avatar.SetPos(startLoc)
	$Avatar.stepCnt = 0
	$DrawMaze.Set(maze,fog,$Avatar)

	#Gen Maze Objects
	for c in $Objects.get_children():
		c.queue_free()
	endPoints.erase(start)
	
	objs.SetIndex(end,AddObj(0,maze.GetLoc(end)))#goal
	endPoints.erase(end)
	
	if dat.get("key",false):
		var keyIndex = endPoints[randi()%len(endPoints)]
		objs.SetIndex(keyIndex,AddObj(4,maze.GetLoc(keyIndex)))
		endPoints.erase(keyIndex)
		
	if dat.get("food",false):
		for p in endPoints:
			objs.SetIndex(p,AddObj(1,maze.GetLoc(p)))
			
	if dat.get("enemy",false):
		for e in crossPoints:
			objs.SetIndex(e,AddObj(2,maze.GetLoc(e)))

	Explore(1)

	#Count Time
	startTime = OS.get_unix_time()
	countTime = true

func SetCam(target):
	var p = cam.get_parent()
	p.remove_child(cam)
	target.add_child(cam)
	cam.set_owner(target)

func AddObj(type,gridPos):
	var obj
	match type:
		0,1,2,3,4:
			obj = mazeObjPrefab[type].instance()
		_: return null
	obj.position = gridToPos(gridPos[0],gridPos[1])
	$DrawMaze.AddObj(obj,gridPos[2])
	return obj

var offset = Vector2.ONE* MazeDefine.gridSize/2
func gridToPos(x,y):
	return Vector2(x,y)*MazeDefine.gridSize + offset

func Move(dir):
	$Avatar.Move(dir)

func Explore(view):
	var gridObj = objs.Get($Avatar.location)
	#print(gridObj)
	if gridObj!=null:
		if is_instance_valid(gridObj):
			gridObj.Trig($Avatar,self)
		
	if fog == null:
		return
	var pos = $Avatar.AvatarPos()
	for y in range(pos.y - view,pos.y+view+1):
		for x in range(pos.x - view,pos.x+view+1):
			if abs(pos.x-x)+abs(pos.y-y) <= view:
				fog.CheckSet(false,[x,y])
	$DrawMaze.Refresh()

#func _physics_process(delta):
#	var pos = AvatarPos()
#	if Input.is_action_pressed("ui_up"):
#		if maze.UpWall(pos.x,pos.y) == ".":
#			Move(Vector2.UP)
#	if Input.is_action_pressed("ui_left"):
#		if maze.LeftWall(pos.x,pos.y) == ".":
#			Move(Vector2.LEFT)
#	if Input.is_action_pressed("ui_right"):
#		if maze.RightWall(pos.x,pos.y) == ".":
#			Move(Vector2.RIGHT)
#	if Input.is_action_pressed("ui_down"):
#		if maze.DownWall(pos.x,pos.y) == ".":
#			Move(Vector2.DOWN)

func _input(event):
	var pos = $Avatar.AvatarPos()
#	if event.is_action_pressed("Left"):
#		if maze.GetWall(pos.x,pos.y,pos.z,1) == ".":
#			Move(Vector3.LEFT)
#	if event.is_action_pressed("Right"):
#		if maze.GetWall(pos.x,pos.y,pos.z,0) == ".":
#			Move(Vector3.RIGHT)
#	if event.is_action_pressed("Up"):
#		if maze.GetWall(pos.x,pos.y,pos.z,3) == ".":
#			Move(Vector3.DOWN)
#	if event.is_action_pressed("Down"):
#		if maze.GetWall(pos.x,pos.y,pos.z,2) == ".":
#			Move(Vector3.UP)
	
	if event.is_action_pressed("RUp"):
		if maze.GetWall(pos.x,pos.y,pos.z,5) == ".":
			$DrawMaze.Up()
			Move(Vector3.FORWARD)
			#$DrawMaze.Refresh()
	if event.is_action_pressed("RDown"):
		if maze.GetWall(pos.x,pos.y,pos.z,4) == ".":
			$DrawMaze.Down()
			Move(Vector3.BACK)
			#$DrawMaze.Refresh()

#	if event.is_action_pressed("Shift"):
#		dfs.run()
#		$DrawMaze.update()

func _on_Left_pressed():
	var pos = $Avatar.AvatarPos()
	if maze.GetWall(pos.x,pos.y,pos.z,1) == ".":
		Move(Vector3.LEFT)

func _on_Right_pressed():
	var pos = $Avatar.AvatarPos()
	if maze.GetWall(pos.x,pos.y,pos.z,0) == ".":
		Move(Vector3.RIGHT)

func _on_Up_pressed():
	var pos = $Avatar.AvatarPos()
	if maze.GetWall(pos.x,pos.y,pos.z,3) == ".":
		Move(Vector3.DOWN)

func _on_Down_pressed():
	var pos = $Avatar.AvatarPos()
	if maze.GetWall(pos.x,pos.y,pos.z,2) == ".":
		Move(Vector3.UP)

func Win():
	var elapsed:int = endTime - startTime
	var minutes = elapsed / 60
	var seconds = elapsed % 60
	var title = "Win"
	var labText = "Step:%3d Time:%02d:%02d"%[$Avatar.stepCnt,minutes, seconds]
	countTime = false
	match tmpDat.mode:
		0:
			MazeGlb.unlockLevel = tmpDat.lv+1
			msgDlg.Exec(title,["Next Level","Back"],labText)
			var res = yield(msgDlg,"selected")
			match res:
				0:
					StartLevel(tmpDat.lv+1)
				1:
					MazeGlb.UILevelSelection()
					queue_free()
		1:
			msgDlg.Exec(title,["Retry","Back"],labText)
			var res = yield(msgDlg,"selected")
			match res:
				0:Retry()
				1:BackToOptionMenu()

func _process(delta):
	if countTime:
		endTime = OS.get_unix_time()
		var elapsed:int =  endTime - startTime
		var minutes = elapsed / 60
		var seconds = elapsed % 60
		timeLabel.text = "%02d : %02d" % [minutes, seconds]

func _on_MenuBtn_pressed():
	$HUD/MainMenu.Init(["Resume","Restart","Back","Exit"])

func StartLevel(index):
	var data = MazeGlb.levelDb[index].duplicate(true)
	data.mode = 0
	data.lv = index
	NewGame(data)

func Retry():
	NewGame(tmpDat)

func BackToOptionMenu():
	MazeGlb.UIMazeOption()
	queue_free()

func _on_MainMenu_select(index):
	match index:
		0:pass
		1:Retry()
		2:BackToOptionMenu()
		3:get_tree().quit()
