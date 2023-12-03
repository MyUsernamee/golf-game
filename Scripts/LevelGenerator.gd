
class_name LevelGenerator

extends Node3D

# Creates levels based off node pieces
@export var start_piece: PackedScene = null # The starting piece
@export var end_piece: PackedScene = null # The ending piece
@export var pieces: Array[PackedScene] = [] # All pieces that can be generated

func _ready():
	# Generate the level
	generate()


func generate():

	# WE Start by spawning the start piece
	var start = start_piece.instantiate()
	add_child(start)
	
