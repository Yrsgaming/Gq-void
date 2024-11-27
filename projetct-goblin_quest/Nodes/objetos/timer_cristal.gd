extends Node2D
@export var wait_time = 0.0



func  _ready() -> void:
	await get_tree().create_timer(wait_time).timeout
	$AnimationPlayer.play("on_off")
