extends Node2D


func _on_cart_area_area_entered(area: Area2D) -> void:
	var velocity = area.get_parent().dir
	if velocity > 50:
		queue_free()
