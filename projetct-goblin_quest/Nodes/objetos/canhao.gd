extends Node2D
@export var dir = Vector2.ZERO
@export var SPEED_X = 0
@export var SPEED_Y = 0

var player_1_in_canhao = false
var player_2_in_canhao = false
var player_1_ready = false 
var player_2_ready = false

var timer = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if dir.x > 1:
		$Node2D.rotation_degrees = -60
	elif dir.x < 1:
		$Node2D.rotation_degrees = 60
	else:
		$Node2D.rotation_degrees = 0
	






func _physics_process(delta: float) -> void:
	if player_1_in_canhao == true:
		$p1_input.visible = true
	else:
		$p1_input.visible = false
	if player_2_in_canhao == true:
		$p2_input.visible = true
	else:
		$p2_input.visible = false
	
	if player_1_in_canhao == true and Input.is_action_just_pressed("p1_up"):
		if timer == false:
			timer = true
			$Timer.start()
		player_1_ready = true
		get_parent().get_off_p1()
	if player_2_in_canhao == true and Input.is_action_just_pressed("p2_up"):
		if timer == false:
			timer = true
			$Timer.start()
			print("start_timer")
		player_2_ready = true
		get_parent().get_off_p2()
	
	if player_1_ready == true and Input.is_action_just_pressed("p1_down"):
		player_1_ready = false
		get_parent().come_back_p1()
	if player_2_ready == true and Input.is_action_just_pressed("p2_down"):
		player_2_ready = false
		get_parent().come_back_p2()
	



func _on_canhao_area_entered(area: Area2D) -> void:
	var player_door = area.get_parent()
	
	if player_door.player == 1:
		player_1_in_canhao = true
	elif player_door.player == 2:
		player_2_in_canhao = true



func _on_canhao_area_exited(area: Area2D) -> void:
	var player_door = area.get_parent()
	
	if player_door.player == 1:
		player_1_in_canhao = false
	elif player_door.player == 2:
		player_2_in_canhao = false


func _on_timer_timeout() -> void:
	timer = false
	if player_1_ready == true:
		player_1_ready = false
		get_parent().come_back_p1()
		var player = get_parent().player_1
		player.add_vector(SPEED_X,SPEED_Y)
	if player_2_ready == true:
		player_2_ready = false
		get_parent().come_back_p2()
		var player = get_parent().player_2
		player.add_vector(SPEED_X,SPEED_Y)
