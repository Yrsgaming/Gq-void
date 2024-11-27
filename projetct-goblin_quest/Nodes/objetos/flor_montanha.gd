extends Node2D

@export var altura = 0

var start = false


func _on_area_2d_area_entered(area: Area2D) -> void:
	if start == false:
		start = true
		$AnimationPlayer.play("desabrochar")
		var tween = create_tween()
		tween.tween_property($pivot,"position", Vector2(0,altura), 1)
