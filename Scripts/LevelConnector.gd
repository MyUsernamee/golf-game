class_name LevelConnector

extends Node3D

func _ready():
    var draw = Draw3D.new()
    add_child(draw)
    draw.draw_line([position, position + transform.basis.z * 2], Color(1, 0, 0))
