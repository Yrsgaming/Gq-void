extends Node2D


@export var timing_reverse = false
@export var speed_scale = 1.0


func _start(world):
	if $RayCast2D.is_colliding() == true:
		self.rotation_degrees = -180
		$CPUParticles2D.gravity.y = 600
	$AnimationPlayer.speed_scale = speed_scale
	if timing_reverse == true:
		$AnimationPlayer.play("start_timing_2")
	else:
		$AnimationPlayer.play("start_timing")
