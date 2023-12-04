class_name LevelConnector

extends Node3D

func _ready():
	var draw = Draw3D.new()
	add_child(draw)
	draw.draw_line([position, position + Vector3(0, 0, 1)], Color(1, 0, 0))