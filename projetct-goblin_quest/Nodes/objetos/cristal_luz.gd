extends Sprite2D



func light_up():
	$AnimationPlayer.play("ligando")
	await $AnimationPlayer.animation_finished
	$AnimationPlayer.play("estavel")
