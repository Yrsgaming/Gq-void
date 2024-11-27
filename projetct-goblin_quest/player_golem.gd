extends CharacterBody2D

@export var player = 1


var can_jump = true
var down_time = false
var JUMP_FORCE = -1150
var SPEED = 620
var gravity = 46
var gravity_add = 0
var dead = false
var attacking = false
var dir = 1
var objeto_in_range = null
var objeto_throw = false
var holding_object = false
var object_hold = null
const BBETA = preload("res://Nodes/projetil/base_bullet.tscn")

var not_move = false
var world = null
var friend_dead = false
func _start() -> void:
	$Anchor_anim.play("anim_anchor")
	$Anchor_red/RespawnRedleft.visible = false
	$Anchor_red/RespawnRedright.visible = false
	$Anchor_yellow/RespawnYellowleft.visible = false
	$Anchor_yellow/RespawnYellowright.visible = false
	world = get_parent()
	
	if true:
		if player == 1:
			world.add_player(player,self)
			$Pivot/player_2.visible = false
		elif player == 2:
			world.add_player(player,self)
			$Pivot/player_1.visible = false

func _physics_process(delta: float) -> void:
	if dead == false and not_move == false:
		if is_on_floor() == false:
			gravity_add = gravity_add + gravity
			velocity.y = velocity.y + gravity
		else:
			gravity_add = gravity
		
		
		try_walk()
		grab_object()
		see_can_jump()
		jump()
		move_and_slide()
		anim()
		force_jump()



func force_jump():
	if player == 1:
		if Input.is_action_pressed("p1_up"):
			$Jump_force/CollisionShape2D.disabled = false
		else:
			$Jump_force/CollisionShape2D.disabled = true
	elif player == 2:
		if Input.is_action_pressed("p2_up"):
			$Jump_force/CollisionShape2D.disabled = false
		else:
			$Jump_force/CollisionShape2D.disabled = true

func attack():
	if player == 1 and Input.is_action_just_pressed("p1_throw"):
		attacking = true
		$AnimationPlayer.play("attack_anim_p1")
	if player == 2 and Input.is_action_just_pressed("p2_throw"):
		attacking = true
		$AnimationPlayer.play("attack_anim_p2")


func throw() -> void:
	if player == 1:
		if holding_object == true and Input.is_action_just_pressed("p1_throw") :
			$pick_object/CollisionShape2D.disabled = false
			object_hold.lock_out(dir)
			object_hold = null
			holding_object = false
	elif player == 2:
		if holding_object == true and Input.is_action_just_pressed("p2_throw") :
			$pick_object/CollisionShape2D.disabled = false
			object_hold.lock_out(dir)
			object_hold = null
			holding_object = false



func grab_object() -> void:
	if objeto_in_range != null and holding_object == false:
		if player == 1:
			if Input.is_action_just_pressed("p1_grab") and objeto_in_range.pegavel == true:
				$pick_object/CollisionShape2D.disabled = true
				holding_object = true
				objeto_in_range.object = self
				objeto_in_range.agarra()
				object_hold = objeto_in_range
		elif player == 2:
			if Input.is_action_just_pressed("p2_grab") and objeto_in_range.pegavel == true:
				$pick_object/CollisionShape2D.disabled = true
				holding_object = true
				objeto_in_range.object = self
				objeto_in_range.agarra()
				object_hold = objeto_in_range




func see_can_jump() -> void:
	if is_on_floor():
		can_jump = true
	if is_on_floor() == false and down_time == false and can_jump == true:
		down_time = true
		$Coyote_window.start()
		await $Coyote_window.timeout
		can_jump = false
		down_time = false




func anim() -> void:
	if velocity.x != 0 and is_on_floor() and attacking == false:
		if player == 1:
			$AnimationPlayer.play("walking_anim_p1")
		elif player == 2:
			$AnimationPlayer.play("walking_anim_p2")
	if velocity.x > 0:
		$Pivot.scale.x = 1
		dir = 1
	elif velocity.x < 0:
		$Pivot.scale.x = -1
		dir = -1
	if is_on_floor() == false and attacking == false:
		if player == 1:
			$AnimationPlayer.play("jump_anim_p1")
		elif player == 2:
			$AnimationPlayer.play("jump_anim_p2")
	elif velocity.x == 0 and attacking == false:
		if player == 1:
			$AnimationPlayer.play("Indie_anim_p1")
		elif player == 2:
			$AnimationPlayer.play("Indie_anim_p2")



func jump() -> void:
	if player == 1:
		if Input.is_action_pressed("p1_up") and can_jump == true:
			velocity.y = JUMP_FORCE
			world.switch_red_()
			can_jump = false
			down_time = false
	elif  player == 2:
		if Input.is_action_pressed("p2_up") and can_jump == true:
			velocity.y = JUMP_FORCE
			world.switch_yellow_()
			down_time = false
			can_jump = false

func try_walk() -> void:
	if player == 1:
		if Input.is_action_pressed("p1_left"):
			velocity.x = -SPEED
		elif Input.is_action_pressed("p1_right"):
			velocity.x = SPEED
		else:
			velocity.x = 0
	elif player == 2:
		if Input.is_action_pressed("p2_left"):
			velocity.x = -SPEED
		elif Input.is_action_pressed("p2_right"):
			velocity.x = SPEED
		else:
			velocity.x = 0

func death() -> void:
	$Pivot.visible = false
	$Sprite2D.visible = false
	self.global_position.y = -2000
	dead = true
	$Death_timer.start()
	if player == 1:
		self.world.player_1_death()
	elif player == 2:
		self.world.player_2_death()

func get_local() -> Vector2:
	return $Grab_location.global_position
func _on_force_jump_area_entered(area: Area2D) -> void:
	velocity.y = JUMP_FORCE


func _on_pick_object_area_entered(area: Area2D) -> void:
	var objeto = area.get_parent().get_parent()
	objeto_in_range = objeto


func _on_pick_object_area_exited(area: Area2D) -> void:
	objeto_in_range = null


func _on_death_zone_area_entered(area: Area2D) -> void:
	if area.get_parent().alive == true:
		death()

func get_spawn_location():
	if $Raycast/verificarspawn3.is_colliding() == false:
		return $Raycast/verificarspawn3.global_position
	elif $Raycast/verificarspawn4.is_colliding() == false:
		return $Raycast/verificarspawn4.global_position
	else:
		return null

func hide_spawn_location():
	$Anchor_red/RespawnRedleft.visible = false
	$Anchor_red/RespawnRedright.visible = false
	$Anchor_yellow/RespawnYellowleft.visible = false
	$Anchor_yellow/RespawnYellowright.visible = false
func show_spawn_location():
	if player == 2:
		if $Raycast/verificarspawn3.is_colliding() == false:
			$Anchor_red/RespawnRedleft.visible = false
			$Anchor_red/RespawnRedright.visible = true
		elif $Raycast/verificarspawn4.is_colliding() == false:
			$Anchor_red/RespawnRedleft.visible = true
			$Anchor_red/RespawnRedright.visible = false
		else:
			$Anchor_red/RespawnRedleft.visible = false
			$Anchor_red/RespawnRedright.visible = false
	if player == 1:
		if $Raycast/verificarspawn3.is_colliding() == false:
			$Anchor_yellow/RespawnYellowleft.visible = false
			$Anchor_yellow/RespawnYellowright.visible = true
		elif $Raycast/verificarspawn4.is_colliding() == false:
			$Anchor_yellow/RespawnYellowleft.visible = true
			$Anchor_yellow/RespawnYellowright.visible = false
		else:
			$Anchor_yellow/RespawnYellowleft.visible = false
			$Anchor_yellow/RespawnYellowright.visible = false



func not_show():
	self.visible = false
	$CollisionShape2D.disabled = true
	$Jump_force/CollisionShape2D.disabled = true
	$Pivot/Hit_box/CollisionShape2D.disabled = true
	$"Death-ZONE/CollisionShape2D".disabled = true
	$Door_box/CollisionShape2D.disabled = true
	not_move = true

func now_show():
	self.visible = true
	$CollisionShape2D.disabled = false
	$Jump_force/CollisionShape2D.disabled = false
	$Pivot/Hit_box/CollisionShape2D.disabled = false
	$"Death-ZONE/CollisionShape2D".disabled = false
	$Door_box/CollisionShape2D.disabled = false
	not_move = false


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "attack_anim_p1":
		attacking = false
	elif anim_name == "attack_anim_p2":
		attacking = false


func _on_audio_stream_player_finished() -> void:
	var bullet_inst = BBETA.instantiate()
	world.add_child(bullet_inst)
	bullet_inst.start(self.global_position,dir)


func _on_explosion_death_zone_area_entered(area: Area2D) -> void:
	queue_free()
