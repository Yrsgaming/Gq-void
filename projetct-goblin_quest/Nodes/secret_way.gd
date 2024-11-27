extends Node2D

@export var scene = "res://Nodes/Worlds/world_teste.tscn"

func _on_area_2d_area_entered(area: Area2D) -> void:
	get_parent().secret_scene(scene)
