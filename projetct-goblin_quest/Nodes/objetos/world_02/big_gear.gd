extends Node2D

@export var dir = 0
@export var speed_scale = 1.0
var stopped = false

var plataforms = []


func _ready() -> void:
	$AnimationPlayer.speed_scale = speed_scale
	if dir == 1:
		$AnimationPlayer.play("Rotation_horario")
	elif dir == 0:
		$AnimationPlayer.play_backwards("Rotation_horario")

func get_plataform(child):
	plataforms.append(child)

func spark():
	for i in plataforms.size():
		pass



func change_dir():
	stopped = false
	$CentralGear.frame = 0
	spark()
	if dir == 1:
		dir = 0 
		$AnimationPlayer.play_backwards("Rotation_horario")
	elif dir == 0:
		dir = 1
		$AnimationPlayer.play("Rotation_horario")

func stop():
	if stopped == false:
		stopped = true
		$CentralGear.frame = 1
		$AnimationPlayer.pause()
	elif stopped == true:
		stopped = false
		$CentralGear.frame = 0
		if dir == 1:
			$AnimationPlayer.play("Rotation_horario")
		elif dir == 0:
			$AnimationPlayer.play_backwards("Rotation_horario")
