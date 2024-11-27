extends AnimatedSprite2D

var start = false


func _ready() -> void:
	$AnimationPlayer.play("brilho")


func _on_area_2d_area_entered(area: Area2D) -> void:
	self.play("hit")
	get_parent().start_light()


func _on_area_2d_2_area_entered(area: Area2D) -> void:
	if start == false:
		start = true
		$AnimationPlayer.play("brilhoaumentar")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "brilhoaumentar":
		$AnimationPlayer.play("brilho_estavel")
