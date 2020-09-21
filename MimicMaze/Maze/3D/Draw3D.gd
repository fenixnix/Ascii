extends Spatial

var maze:Maze3D

func Set(_maze:Maze3D):
	maze = _maze
	Refresh()

func Refresh():
	$X.clear()
	$Y.clear()
	$Z.clear()
	for z in maze.size[2]:
		for y in maze.size[1]:
			for x in maze.size[0]:
				var pos = to_global(Vector3(x,y,z))
				if pos.z<.5 && pos.z>-.5:
					if maze.GetWall(x,y,z,0)!='.':
						$X.set_cell_item(x,y,z,0)
					if maze.GetWall(x,y,z,2)!='.':
						$Y.set_cell_item(x,y,z,2)
					if maze.GetWall(x,y,z,4)!='.':
						$Z.set_cell_item(x,y,z,1)
