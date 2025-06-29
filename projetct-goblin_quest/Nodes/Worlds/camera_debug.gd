extends Node2D
var alvo
@onready var camera_2d: Camera2D = $Camera_game/CanvasLayer/camera_1_box/SubViewport/Camera2D
@onready var camera_2d_2: Camera2D = $Camera_game/CanvasLayer/camera_2_box/SubViewport2/Camera2D2
@onready var camera_game: Node2D = $Camera_game

func _start(world,player1,player2) -> void:
	camera_game._start(world,player1,player2)

func _physics_process(delta: float) -> void:
	if alvo != null:
		self.position.x = alvo.position.x
		self.position.y = alvo.position.y
	else:
		pass
func _change_alvo(alvo):
	camera_game._change_alvo_principal(alvo)

func _change_mode(mode):
	camera_game._change_camera_mode(mode)

func set_limit(limit_left,limit_right,limit_top,limit_bottom):
	camera_2d.limit_left = limit_left
	camera_2d.limit_right = limit_right
	camera_2d.limit_top = limit_top
	camera_2d.limit_bottom = limit_bottom
	camera_2d_2.limit_left = limit_left
	camera_2d_2.limit_right = limit_right
	camera_2d_2.limit_top = limit_top
	camera_2d_2.limit_bottom = limit_bottom
