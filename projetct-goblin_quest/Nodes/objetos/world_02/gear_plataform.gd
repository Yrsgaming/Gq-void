extends AnimatableBody2D

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent().get_parent().player == 1:
		get_parent().change_dir()



func _ready() -> void:
	get_parent().get_plataform(self)
