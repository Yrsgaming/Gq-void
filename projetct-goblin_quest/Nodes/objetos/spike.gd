extends Node2D

var alive = true

func _start(world):
	if $RayCast2D.is_colliding() == true:
		$Spike/Sprite2D.scale.y = -1
