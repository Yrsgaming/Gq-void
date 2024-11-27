extends AnimatableBody2D

var alive = true
func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent().get_parent().player == 1:
		get_parent().change_dir()
