extends Camera3D

@export var target: RigidBody3D
@export var zoom_amount: float = 8.0
@export var view_distance: float = 4.0
@export var lerp_speed: float = 10.0
@onready var root = get_node("/root/Node3D")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var direction = root.view_direction
	
	if Input.is_action_pressed("click"):
		direction *= zoom_amount
	
	var target_position = target.position - direction * view_distance
	
	
	
	position += (target_position - position) * delta * lerp_speed
	position.y = max(position.y, target.position.y - 0.9)
	
	if position == target.position:
		position += Vector3(1.0, 0.0, 0.0)
	
	look_at(target.position)
