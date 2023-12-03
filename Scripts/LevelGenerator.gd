
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

		if it >= 10:
			# Spawn an end peice
			var end = end_piece.instantiate()
			peice.add_child(end)

			end.position = connector.position
			
			# We then need to rotate the normals to be opposite of the connector
			var normal = connector.transform.basis.z
			var new_normal = end.transform.basis.z

			print("Dot" + str(normal.dot(new_normal)))

			if normal.dot(new_normal) == 1:
				end.rotate_y(PI)
				end.position += connector.position
			elif normal.dot(new_normal) == -1:
				end.position -= connector.position
			else:
				# Dot of two vectors is the cos of the angle between them
				var angle = acos(normal.dot(new_normal))
				var axis = normal.cross(new_normal)
				end.rotate(axis.normalized(), angle)
				end.position -= connector.position.rotated(axis.normalized(), angle)

			return

		var newp = select_random_compatable_peice(connector)
		# We spawn the piece
		var level_piece = newp.instantiate()
		peice.add_child(level_piece)
		var connection = select_random_connector(level_piece)

		print("Connecting: " + str(connector) + " to " + str(connection))

		level_piece.position = connector.position

		# We then need to rotate the normals to be opposite of the connector
		var normal = connector.transform.basis.z
		var new_normal = connection.transform.basis.z

		print("Normal: " + str(normal) + " New Normal: " + str(new_normal))

		if normal.dot(new_normal) == 1:
			level_piece.rotate_y(PI)
			level_piece.position += connection.position
		elif normal.dot(new_normal) == -1:
			#level_piece.rotate_y(PI)
			level_piece.position -= connection.position
		else:
			# Dot of two vectors is the cos of the angle between them
			var angle = acos(normal.dot(new_normal))
			var axis = normal.cross(new_normal)
			level_piece.rotate(axis.normalized(), angle)
			level_piece.position -= connection.position.rotated(axis.normalized(), angle)

		# We delete the connection so we don't use it again
		# WE  actaully delete thenode
		connection.queue_free()
		level_piece.connectors.erase(connection)

		generate_from_peice(level_piece, it + 1)

func select_random_compatable_peice(connector):
	return pieces[randi() % pieces.size()]

func select_random_connector(peice):
	return peice.connectors[randi() % peice.connectors.size()]