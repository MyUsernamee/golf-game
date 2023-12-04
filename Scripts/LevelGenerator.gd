
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

	# We then generate from the start piece
	generate_from_peice(start, 0)
	
func generate_from_peice(peice, it):

	# We start by generating peices on all of the connectors
	for connector in peice.connectors:

		if it >= 50:
			# Spawn an end peice
			var end = end_piece.instantiate()
			peice.add_child(end)
			connect_peices_at_connectors(peice, connector, end, end.connectors[0])

			return

		var newp = select_random_compatable_peice(connector)
		var level_piece = newp.instantiate()
		peice.add_child(level_piece)
		var connection = select_random_connector(level_piece)

		connect_peices_at_connectors(peice, connector, level_piece, connection)

		# We delete the connection so we don't use it again
		# WE  actaully delete thenode
		connection.queue_free()
		level_piece.connectors.erase(connection)

		generate_from_peice(level_piece, it + 1)

func select_random_compatable_peice(connector):
	return pieces[randi() % pieces.size()]

func select_random_connector(peice):
	return peice.connectors[randi() % peice.connectors.size()]

func connect_peices_at_connectors(piece1, connector1, piece2, connector2):

	piece2.position = connector1.position

	# We need to rotate the peice so that the connectors are on the same plane
	var normal1 = connector1.transform.basis.z
	var normal2 = connector2.transform.basis.z

	if normal1.dot(normal2) == 1:
		piece2.rotate_y(PI)
		piece2.position += connector2.position
	elif normal1.dot(normal2) == -1:
		piece2.position -= connector2.position
	else:
		# Dot of two vectors is the cos of the angle between them
		var angle = acos(normal1.dot(normal2))
		var axis = normal1.cross(normal2)
		piece2.rotate(axis.normalized(), angle)
		piece2.position -= connector2.position.rotated(axis.normalized(), angle)
