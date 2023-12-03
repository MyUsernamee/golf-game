extends Node3D

@onready var pointer: Node3D = get_node("Pointer")
@onready var rigidbody: RigidBody3D = get_node("RigidBody")
@onready var root: Node3D = get_node("/root/Node3D")

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	pointer.visible = false

	if Input.is_action_pressed("click"):
		#linear_velocity.x += 1.0
		pointer.look_at_from_position(Vector3.ZERO, root.view_direction, Vector3.UP)
		pointer.visible = true
		pointer.position = rigidbody.position
	
func _integrate_forces(state):
	pass
