extends CharacterBody2D

var alive = true
@export var move_side = 1
var speed = 1000.0
var dir = 0.0

var angulo = 0

var P_R_limit = 6.0
var P_L_limit = 6.0

var gravity = 0
var L_pressed = false
var R_pressed = false
var freeze = false

var players = []
var Fr = 0.01
var keep = false
func _process(delta: float) -> void:
	if freeze == false:
		$AnimationPlayer.speed_scale = dir/50
		if move_side == 1:
			$AnimationPlayer.play("rodar")
		elif move_side == -1:
			$AnimationPlayer.play_backwards("rodar")
		velocity.y = gravity
		up_down()
		friction()
		velocity.x = (dir * speed * delta) * move_side
		if is_on_floor() == false:
			velocity.y = 1200
		else:
			velocity.y = 0
		if dir > 120.0:
			dir = 120.0
	else:
		dir = 0 
	move_and_slide()



func up_down():
	if L_pressed == true and R_pressed == true:
		pass
	elif L_pressed == true and R_pressed == false:
		if $Node2D4/Node2D2/Plataform_L.position.y != P_L_limit:
			$Node2D4/Node2D2/Plataform_L.position.y = $Node2D4/Node2D2/Plataform_L.position.y + 0.5
			$Node2D4/Node2D/Plataform_R.position.y = $Node2D4/Node2D/Plataform_R.position.y - 0.5
			dir = dir + 0.2
	elif L_pressed == false and R_pressed == true:
		if $Node2D4/Node2D/Plataform_R.position.y != P_R_limit:
			$Node2D4/Node2D/Plataform_R.position.y = $Node2D4/Node2D/Plataform_R.position.y + 0.5
			$Node2D4/Node2D2/Plataform_L.position.y = $Node2D4/Node2D2/Plataform_L.position.y - 0.5
			dir = dir + 0.2
	else: 
		pass
func friction():
	if dir != 0.0:
		if dir > 0.01:
			dir = dir - Fr
		elif dir < 0.01:
			dir = 0


func _on_l_area_entered(area: Area2D) -> void:
	L_pressed = true




func _on_r_area_entered(area: Area2D) -> void:
	R_pressed = true

func _on_r_area_exited(area: Area2D) -> void:
	R_pressed = false

func _on_l_area_exited(area: Area2D) -> void:
	L_pressed = false


func _on_area_2d_area_entered(area: Area2D) -> void:
	freeze = false
	if dir < 2.0:
		if move_side == 1:
			move_side = -1
		elif move_side == -1:
			move_side = 1
	else:
		dir = dir - 10.0
		if dir < 0.0:
			dir = 0.0


func _on_player_grab_area_entered(area: Area2D) -> void:
	area.get_parent().object_follow(self)
	players.append(area.get_parent())


func _on_player_grab_area_exited(area: Area2D) -> void:
	area.get_parent().object_unfollow()
	players.pop_at(players.find(area.get_parent()))


func _on_area_2d_2_area_entered(area: Area2D) -> void:
	if dir < 5.0:
		freeze = true
	else:
		dir = dir - 10.0
		if dir < 0.0:
			dir = 0.0
