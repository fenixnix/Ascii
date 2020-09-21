extends VBoxContainer

func Init(srcSheet):
	$TileSize.Init("Tile Size",srcSheet.tileSize)
	$GridSize.Init("Grid Size",srcSheet.gridSize)
	$GridOffset.Init("Grid Offset",srcSheet.gridOffset)
	$StartPoint.Init("Start Point",srcSheet.startPoint)
