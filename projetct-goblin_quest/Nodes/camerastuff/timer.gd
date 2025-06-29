extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var camera_game: Node2D = $"../.."

func _start_timer(red):
	if red == true:
		animation_player.play("TimerRed")
	else:
		animation_player.play("TimerYellow")

#chamada timer -> camera -> world -> player
func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "TimerRed":
		camera_game._respawn_player(true)
	elif anim_name == "TimerYellow":
		camera_game._respawn_player(false)
