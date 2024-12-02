extends StaticBody2D


func _start(world):
	if $RayCast2D.is_colliding() == true:
		$OneWay.flip_h = true
