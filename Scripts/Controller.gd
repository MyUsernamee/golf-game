extends Node3D

@onready var pointer: Node3D = get_node("Pointer")
@onready var rigidbody: RigidBody3D = get_node("RigidBody")
@onready var root: Node3D = get_node("/root/Node3D")

var power = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	pointer.visible = false # TODO: FIX THIS, Change to a state system instead of this

	if Input.is_action_pressed("click"):
		#linear_velocity.x += 1.0
		var direction = root.view_direction
		direction.y = 0
		pointer.look_at_from_position(Vector3.ZERO, direction, Vector3.UP)


		pointer.visible = true
		pointer.position = rigidbody.position

		pointer.scale = Vector3(power, 1.0, 1.0)

	if Input.is_action_just_pressed("click"):
		power = 0.0

	if Input.is_action_just_released("click"):
		rigidbody.apply_force(root.view_direction * power * 10000.0)
	
func _input(event):
	if event is InputEventMouseMotion:
		power += event.relative.y * 0.01
		power = clamp(power, 0.0, 1.0)

func _integrate_forces(state):
	pass
