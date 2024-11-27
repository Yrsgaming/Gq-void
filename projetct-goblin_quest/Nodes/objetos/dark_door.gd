extends StaticBody2D

var start = false


func _on_area_2d_area_entered(area: Area2D) -> void:
	if start == false:
		start = true
		$AnimationPlayer.play("close")
