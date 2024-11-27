extends StaticBody2D

func _start(world):
	pass

func _on_area_2d_area_entered(area: Area2D) -> void:
	area.get_parent().death()
	$AnimatedSprite2D.play("nhac")
