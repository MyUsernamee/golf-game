extends Camera3D

@export var target: RigidBody3D
@onready var root = get_node("/root/Node3D")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var direction = root.view_direction
	
	if Input.is_action_pressed("click"):
		direction *= 8.0
	
	var target_position = target.position - direction * 4.0
	
	
	
	position += (target_position - position) * delta * 10.0
	position.y = max(position.y, target.position.y - 0.9)
	
	if position == target.position:
		position += Vector3(1.0, 0.0, 0.0	)
	
	look_at(target.position)
		
		
		
		
		
