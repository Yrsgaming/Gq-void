extends Node2D

var player_1_in_door = false
var player_2_in_door = false

var player_1_ready = false
var player_2_ready = false

var world = null
func _start(_world) -> void:
	$AnimationPlayer.play("jumping")
	world = _world


func _physics_process(delta: float) -> void:
	if player_1_in_door == true:
		$p1_input.visible = true
	else:
		$p1_input.visible = false
	if player_2_in_door == true:
		$p2_input.visible = true
	else:
		$p2_input.visible = false
	
	
	
	if player_1_in_door == true and Input.is_action_just_pressed("p1_up"):
		player_1_ready = true
		get_parent().get_parent().get_off_p1()
	if player_2_in_door == true and Input.is_action_just_pressed("p2_up"):
		player_2_ready = true
		get_parent().get_parent().get_off_p2()
	
	if player_1_ready == true and Input.is_action_just_pressed("p1_down"):
		player_1_ready = false
		get_parent().get_parent().come_back_p1()
	if player_2_ready == true and Input.is_action_just_pressed("p2_down"):
		player_2_ready = false
		get_parent().get_parent().come_back_p2()
	
	
	if player_1_ready == true and player_2_ready == true:
		get_parent().get_parent().next_scene()
	
func _on_area_2d_area_entered(area: Area2D) -> void:
	var player_door = area.get_parent()
	
	if player_door.player == 1:
		player_1_in_door = true
	elif player_door.player == 2:
		player_2_in_door = true

func _on_area_2d_area_exited(area: Area2D) -> void:
	var player_door = area.get_parent()
	
	if player_door.player == 1:
		player_1_in_door = false
	elif player_door.player == 2:
		player_2_in_door = false
