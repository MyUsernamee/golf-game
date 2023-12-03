extends Node3D

var view_direction: Vector3 = Vector3.FORWARD
var mouse_delta: Vector2 = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _input(event):

	if event is InputEventMouseMotion:
		mouse_delta = event.relative

	if Input.is_action_pressed("click"):
		return

	if event is InputEventMouseMotion:
		var d = event.relative / 1000.0
		view_direction = view_direction.rotated(Vector3.UP, -d.x)
		view_direction = view_direction.rotated(view_direction.cross(Vector3.UP).normalized(), -d.y)
		