extends Node2D

@onready var scene = "res://Nodes/start_scene.tscn"


func _process(delta: float) -> void:
	if Input.is_key_pressed(KEY_R):
		get_tree().change_scene_to_file(scene)
