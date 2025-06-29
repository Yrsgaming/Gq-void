extends Node2D
var screen_heigth = 1152
var screen_width = 648
@onready var sub_viewport: SubViewport = $CanvasLayer/camera_1_box/SubViewport
@onready var sub_viewport_2: SubViewport = $CanvasLayer/camera_2_box/SubViewport2
@onready var camera_1_box: SubViewportContainer = $CanvasLayer/camera_1_box
@onready var camera_2_box: SubViewportContainer = $CanvasLayer/camera_2_box
@onready var camera_2d: Camera2D = $CanvasLayer/camera_1_box/SubViewport/Camera2D
@onready var camera_2d_2: Camera2D = $CanvasLayer/camera_2_box/SubViewport2/Camera2D2
@onready var timer: Node2D = $CanvasLayer/Timer
@onready var animation_player: AnimationPlayer = $CanvasLayer/AnimationPlayer

@export var limit_x = 600
@export var limit_y = 600
var alvo_principal = null
var alvo_secundario = null


var player_1
var player_2

var follow = false
var mode_atual = 2

func _start(world,player1,player2) -> void:
	_change_camera_mode(2)
	sub_viewport_2.world_2d = world
	sub_viewport.world_2d = world
	alvo_principal = player1
	alvo_secundario = player2
	player_1 = player1
	player_2 = player2
	follow = true


func _physics_process(delta: float) -> void:
	if player_1.dead == true or player_2.dead == true:
		return
	
	check_distance(player_1,player_1.global_position - player_2.global_position)
	check_distance(player_2,player_2.global_position - player_1.global_position)

func check_distance(player,distance):
	var change_mode = false
	
	if distance.x > limit_x:
		change_mode = true
	if distance.x < -limit_x:
		change_mode = true
	if distance.y > limit_y:
		change_mode = true
	if distance.y < -limit_y:
		change_mode = true
	
	if change_mode:
		_change_camera_mode(1)
	else:
		_change_camera_mode(2)



# timer -> camera -> world - > player
func _respawn_player(player1):
	get_parent()._respawn_player(player1)

func _change_camera_mode(mode):
	if mode == 1 and mode_atual != 1:
		mode_atual = 1
		animation_player.play_backwards("2-1")
	if mode == 2 and mode_atual != 2:
		mode_atual = 2
		animation_player.play("2-1")

func _change_alvo_principal(player1: bool):
	if player1:
		alvo_principal = player_1
		alvo_secundario = player_2
	else:
		alvo_principal = player_2
		alvo_secundario = player_1

# world -> camera -> timer
func _player_timer(red: bool):
	timer._start_timer(red)


func _process(delta: float) -> void:
	if follow == true:
		camera_2d.global_position = alvo_principal.global_position
		camera_2d_2.global_position = alvo_secundario.global_position
