extends Node

func _init():
	var grid = Grid.new([2,3,4])
	var index = grid.GetIndex([1,2,1])
	print("index:",index)
	var loc = grid.GetLoc(index)
	print("loc:",loc)
