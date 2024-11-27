extends AnimatableBody2D

var start = false

func _ready() -> void:
	await get_tree().create_timer(1).timeout
	$AnimationPlayer.play("up_down")

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent().get_parent().player == 1:
		get_parent().change_dir()


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "up_down":
		$AnimationPlayer.play_backwards("down_up")
		$Timer.start()

func _on_area_2d_2_area_entered(area: Area2D) -> void:
	area.get_parent().add_piston_vector(-1700,0.1)


func _on_timer_timeout() -> void:
	$AnimationPlayer.play("up_down")
