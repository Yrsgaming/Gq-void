extends Node2D

func _start(world):
	pass

func _on_breakzone_area_entered(area: Area2D) -> void:
	print("death")
	queue_free()
