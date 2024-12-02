extends AnimatableBody2D


func P_not_show():
	$PlataformIce.visible = false
	$CollisionShape2D.disabled = true

func P_show():
	$PlataformIce.visible = true
	$CollisionShape2D.disabled = false






func _on_area_2d_2_area_entered(area: Area2D) -> void:
	$AnimationPlayer.play("derreter")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "derreter":
		get_parent().new_plataform()
