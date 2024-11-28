extends Node2D

@export var dir = 0
@export var speed_scale = 1.0
var stopped = false 
var plataforms = []
func _ready() -> void:
	if dir == 0:
		$AnimationPlayer.play("start")
	else: 
		$AnimationPlayer.play_backwards("start")

func change_dir():
	stopped = false
	$CentralGear.frame = 0
	spark()
	if dir == 1:
		dir = 0 
		$AnimationPlayer.play_backwards("start")
	elif dir == 0:
		dir = 1
		$AnimationPlayer.play("start")


func stop():
	if stopped == false:
		stopped = true
		$CentralGear.frame = 1
		$AnimationPlayer.pause()
	elif stopped == true:
		stopped = false
		$CentralGear.frame = 0
		if dir == 1:
			$AnimationPlayer.play("start")
		elif dir == 0:
			$AnimationPlayer.play_backwards("start")
func get_plataform(child):
	plataforms.append(child)

func spark():
	for i in plataforms.size():
		plataforms[i].sparks()
