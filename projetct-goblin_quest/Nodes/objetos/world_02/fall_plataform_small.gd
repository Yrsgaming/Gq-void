extends AnimatableBody2D

var start = false
var end = false
func _on_area_2d_area_entered(area: Area2D) -> void:
	if end == false:
		if area.get_parent().get_parent().player == 1:
			get_parent().change_dir()


func _on_player_detect_area_entered(area: Area2D) -> void:
	if start == false:
		start = true
		$AnimationPlayer.play("break")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	end = true
