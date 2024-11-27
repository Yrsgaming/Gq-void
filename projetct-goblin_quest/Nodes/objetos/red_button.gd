extends Node2D

var world 

func _start(_world) -> void:
	world = _world
	$AnimationPlayer.speed_scale = world.red_speed_scale


func _on_area_2d_area_entered(area: Area2D) -> void:
	$AnimationPlayer.play("start")
	world.on_red()


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "start":
		world.off_red()
