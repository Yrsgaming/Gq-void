extends CanvasLayer


func _ready() -> void:
	$AnimatedSprite2D.play("out_scene")
	$AnimationPlayer.play("RESET")

func player_1_D():
	$AnimationPlayer.play("Red_timer")

func player_2_D():
	$AnimationPlayer.play("Yellow_timer")


func play_in_scene():
	$AnimatedSprite2D.play_backwards("in_scene")

func death_scene():
	$AnimatedSprite2D.play_backwards("death_anim(R)")


func change_scene():
	get_parent().try_change_scene()

func secret_scene(scene):
	get_parent().goto_secret(scene)

func _on_animated_sprite_2d_animation_finished() -> void:
	if $AnimatedSprite2D.animation == "in_scene":
		get_parent().try_change_scene()
	elif $AnimatedSprite2D.animation == "death_anim(R)":
		get_parent().reload_scene()
