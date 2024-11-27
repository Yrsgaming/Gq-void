extends Node2D

var start = false
var alive = true

func _process(delta: float) -> void:
	if $RayCast2D.is_colliding() == true and start == false:
		start = true
		$AnimationPlayer.play("nhac")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "nhac":
		alive = false
