class_name LevelPeice

extends Node3D

var connectors = []

func _ready():
	for child in get_children():
		if child is LevelConnector:
			connectors.append(child)

func get_childern():
	return connectors
