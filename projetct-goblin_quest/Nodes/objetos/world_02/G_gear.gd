extends Node2D

@export var dir = 0
@export var speed_scale = 1.0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer.speed_scale = speed_scale
	if dir == 1:
		$AnimationPlayer.play("Rotation_horario")
	elif dir == 0:
		$AnimationPlayer.play_backwards("Rotation_horario")


func change_dir():
	$GenevaPart1/CentralGear.frame = 0
	if dir == 1:
		dir = 0 
		$AnimationPlayer.play_backwards("Rotation_horario")
	elif dir == 0:
		dir = 1
		$AnimationPlayer.play("Rotation_horario")

func stop():
	$GenevaPart1/CentralGear.frame = 1
	$AnimationPlayer.pause()
