extends StaticBody2D


var melt = false

func _start(world):
	pass

func _on_fire_area_entered(area: Area2D) -> void:
	if melt == false:
		melt = true
		$AnimationPlayer.play("derreter")
