extends AnimatableBody2D
@export var await_timer = 0.0


func _start(world) -> void:
	await get_tree().create_timer(await_timer).timeout
	$AnimationPlayer.play("Up_down")


func _on_area_2d_area_entered(area: Area2D) -> void:
	area.get_parent().add_piston_vector(-1700,0.1)


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Up_down":
		$AnimationPlayer.play_backwards("Up_down_2")
		$Timer.start()


func _on_timer_timeout() -> void:
	$AnimationPlayer.play("Up_down")
