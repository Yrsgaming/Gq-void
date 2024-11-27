extends Node2D

@onready var scene = "res://Nodes/Worlds/world_01.tscn"


func _process(delta: float) -> void:
	if Input.is_key_pressed(KEY_R):
		get_tree().change_scene_to_file(scene)
