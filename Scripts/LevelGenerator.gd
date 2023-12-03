
extends Node3D

# Creates levels based off node peices
@export var peices: Array[PackedScene] = [] # All peices that can be generated

func _ready():
    # Generate the level
    load_peices()
    generate()

func load_peices():
    

func generate():

