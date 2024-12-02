extends Node2D
var world 

var speed_scale = 1.0

func _start(_world) -> void:
	world = _world
	$AnimationPlayer.speed_scale =_world.red_valve_speed_scale




func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "start":
		$AnimatedSprite2D.play_backwards("on")
		world.cano_red = false


func _on_area_2d_area_entered(area: Area2D) -> void:
	$AnimationPlayer.play("start")
	$AnimatedSprite2D.play("on")
	world.cano_red = true
