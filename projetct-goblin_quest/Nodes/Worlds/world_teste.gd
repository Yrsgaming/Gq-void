extends Node2D



var player_1
var player_2
@export var limit_left = 0
@export var limit_right = 3500
@export var limit_up = -1600
@export var limit_down = 0
@export var invs_door = false
@export var red_speed_scale = 1.0
@export var next_level = "res://Nodes/Worlds/world_01.tscn"
@export var belt_ritmo = 1.0
@export var piece_belt_velocity = 2.0
@export var belt_sempre_on = false
var red_ = false
var blue_ = false
var yellow = false
var switch_red = false
var switch_yellow = false
var vasos = 0
var light_0 = true
var light_1 = true

var start_level = "res://Nodes/Worlds/world_01.tscn"

var p1_can_revive = true
var p2_can_revive = true

var p1_try_revive = false
var p2_try_revive = false



var p2_in_object = false
func p1_dark_zone():
	p1_can_revive = false

func p1_out_dark_zone():
	p1_can_revive = true
	if p2_try_revive == true:
		player_2._on_death_timer_timeout()
		p2_try_revive = false

func p1_revive():
	if p1_can_revive == true:
		return true
	else:
		p1_try_revive = true
		return false
func p2_revive():
	if p2_can_revive == true:
		return true
	else:
		p2_try_revive = true
		return false


func p2_lock_obj(obj):
	player_2.lock_obj(obj)

func p2_unlock_obj(obj):
	obj.unlock()
	player_2.unlock_obj()


func p2_dark_zone():
	p2_can_revive = false

func remove_p2_only_bullet():
	player_2.remove_only_one_bullet()

func p2_out_dark_zone():
	p2_can_revive = true
	if p1_try_revive == true:
		player_1._on_death_timer_timeout()
		p1_try_revive = false



func restart_game():
	get_tree().change_scene_to_file(start_level)

func add_player(num,player):
	if num == 1:
		player_1 = player
	elif num ==2:
		player_2 = player
func add_vaso_count():
	vasos = vasos + 1

func break_light(light):
	if light == 0:
		light_0 = false
	elif light == 1:
		light_1 = false

func check_light(light):
	if light == 0:
		return light_0
	elif light == 1:
		return light_1
func switch_red_():
	if switch_red == false:
		switch_red = true
	else:
		switch_red = false

func switch_yellow_():
	if switch_yellow == false:
		switch_yellow = true
	else:
		switch_yellow = false

func remove_vasos():
	vasos = vasos -1
func on_red():
	red_ = true

func off_red():
	red_ = false

func on_blue():
	blue_ = true

func off_blue():
	blue_ = false

func on_yellow():
	yellow = true

func off_yellow():
	yellow = false


func _ready() -> void:
	$Player._start()
	$Player2._start()
	$Camera_debug._start()
	$Camera_debug.set_limit(limit_left,limit_right,limit_up,limit_down)
	$TileMapLayer._start(self)

func _process(delta: float) -> void:
	reset()
	if player_1.dead == true and player_2.dead == true:
		$CanvasLayer.death_scene()
	if Input.is_key_pressed(KEY_P):
		next_scene()
	if Input.is_key_pressed(KEY_F4) and Input.is_key_pressed(KEY_B):
		restart_game()

func player_dead(player):
	if player == 1:
		change_camera_focus(2)
	elif player == 2:
		change_camera_focus(1)

func reload_scene():
	get_tree().reload_current_scene()
func player_1_death():
	player_2.friend_dead = true
	change_camera_focus(2)
	$CanvasLayer.player_1_D()


func change_camera_focus(player):
	if player_1.friend_dead == false or player_2.friend_dead == false:
		if player == 1:
			player_2.show_flag(false)
			player_1.show_flag(true)
			$Camera_debug.alvo = player_1
		elif player == 2:
			player_2.show_flag(true)
			player_1.show_flag(false)
			$Camera_debug.alvo = player_2
	else:
		$Camera_debug.alvo = null
func player_2_death():
	player_1.friend_dead = true
	change_camera_focus(1)
	$CanvasLayer.player_2_D()

func next_scene():
	$CanvasLayer.play_in_scene()

func secret_scene(scene):
	$CanvasLayer.secret_scene(scene)

func goto_secret(scene):
	get_tree().change_scene_to_file(scene)

func try_change_scene():
	get_tree().change_scene_to_file(next_level)
	
func get_off_p1():
	player_1.not_show()


func reset():
	if Input.is_key_pressed(KEY_R):
		reload_scene()
func revived(P):
	if P == player_1.player:
		player_2.friend_dead = false
	elif P == player_2.player:
		player_1.friend_dead = false
func get_off_p2():
	player_2.not_show()

func come_back_p1():
	player_1.now_show()

func come_back_p2():
	player_2.now_show()
