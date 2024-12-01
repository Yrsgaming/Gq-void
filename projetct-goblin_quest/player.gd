extends CharacterBody2D

@export var player = 1
@export var power = 1

var vector_imun = false
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
var add_vector_y = 0
var add_vector_x = 0
const CONTROLB = preload("res://Nodes/projetil/bala_control.tscn")
const BBETA = preload("res://Nodes/projetil/base_bullet.tscn")
const ICEB = preload("res://Nodes/projetil/ice_bullet.tscn")

var belt_velocity = 0

var Input_move_vector = 0
var add_vector_piston = 0
var not_move = false
var world = null
var friend_dead = false
var follow = false
var follow_vector = Vector2.ZERO
var follow_object = null

var vector_rigid = Vector2.ZERO
var stun = false

var trying_teleport = false

var jump_reverse = false
var only_one_bullet = false
var control = true
var obj_lock = null
func lock_obj(obj):
	obj_lock = obj
	control = false

func unlock_obj():
	obj_lock = null
	control = true


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
			show_flag(true)
		elif player == 2:
			world.add_player(player,self)
			$Pivot/player_1.visible = false
			show_flag(false)

func try_teleport():
	
	if player == 1:
		if Input.is_action_pressed("p1_teleport"):
			if trying_teleport == false:
				trying_teleport = true
				$Anchor_anim.play("Death_timer")
				if $TeleTimer.is_stopped():
					$TeleTimer.start(1.2)
		if Input.is_action_just_released("p1_teleport"):
			if trying_teleport == true:
				$Anchor_anim.play("not_show_death_timer")
				trying_teleport = false
				$TeleTimer.stop()
	elif player == 2:
		if Input.is_action_pressed("p2_teleport"):
			if trying_teleport == false:
				trying_teleport = true
				$Anchor_anim.play("Death_timer")
				if $TeleTimer.is_stopped():
					$TeleTimer.start(1.2)
		if Input.is_action_just_released("p2_teleport"):
			$Anchor_anim.play("not_show_death_timer")
			if trying_teleport == true:
				trying_teleport = false
				$TeleTimer.stop()




func fire_breath():
	if Input.is_action_pressed("p2_throw"):
		$AnimationPlayer.play("attack_anim_p2_power_4" 	)
		attacking = true
		$Pivot/Hit_magic_fire/CollisionShape2D.disabled = false
		if dir == 1:
			$Particles/Right.emitting = true
			$Particles/Left.emitting = false
		elif dir == -1:
			$Particles/Right.emitting = false
			$Particles/Left.emitting = true
	else:
		$Pivot/Hit_magic_fire/CollisionShape2D.disabled = true
		$Particles/Right.emitting = false
		$Particles/Left.emitting = false
		attacking = false
func show_flag(show):
	if show == true:
		$Pivot/Flag.visible = true
	else:
		$Pivot/Flag.visible = false

func follow_rigid(dir_rigid):
	pass
	#ector_rigid = dir_rigid


func remove_only_one_bullet():
	only_one_bullet = false
func _physics_process(delta: float) -> void:
	_remove_add_vector()
	if obj_lock != null:
		if Input.is_action_just_pressed("p2_grab"):
			print("try")
			get_parent().p2_unlock_obj(obj_lock)
	
	if not_move == true:
		velocity = Vector2.ZERO
	if dead == false and not_move == false and control == true:
		if jump_reverse == true and power == 3:
			if is_on_floor():
				velocity.y = -200
		if $belt.is_colliding() == true:
			check_vector_belt()
		else:
			if belt_velocity > 0:
				belt_velocity = belt_velocity - 10
				if is_on_floor():
					belt_velocity = 0
		if is_on_floor() == false and add_vector_y != 0 :
			velocity.y = add_vector_y + add_vector_piston * delta
		elif is_on_floor() == false and add_vector_y == 0 and add_vector_piston != 0:
			gravity_add = gravity_add + gravity * delta
			velocity.y = gravity + add_vector_piston
		elif is_on_floor() == false and add_vector_y == 0 and add_vector_piston == 0:
			gravity_add = gravity_add + gravity * delta
			velocity.y = velocity.y + gravity + add_vector_piston
			
		if is_on_floor() and vector_imun == true:
			velocity.y = add_vector_y + add_vector_piston + vector_rigid.y * delta
		elif is_on_floor():
			add_vector_x = 0
			add_vector_y = 0
			gravity_add = gravity + add_vector_piston + vector_rigid.y * delta
		
		else:
			follow_vector = Vector2.ZERO
		change_camera_input()
		try_teleport()
		try_walk(delta)
		grab_object()
		see_can_jump()
		jump(delta)
		anim()
		force_jump()
		if power == 4 and player == 2:
			fire_breath()
		if friend_dead == true:
			show_spawn_location()
		else:
			hide_spawn_location()
		if holding_object == true:
			throw()
		else:
			attack()
	if control == false:
		if is_on_floor() == false:
			velocity.y = 400
	move_and_slide()



func check_vector_belt():
	var target = $belt.get_collider().get_parent()
	belt_velocity = target.move_dir

func change_camera_input():
	if $Pivot/Flag.visible == true:
		if player == 1 and Input.is_action_just_pressed("p1_change_flag"):
			get_parent().change_camera_focus(2)
		elif player == 2 and Input.is_action_just_pressed("p2_change_flag"):
			get_parent().change_camera_focus(1)

func get_object_in_range():
	return objeto_in_range

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
	if power == 1:
		if player == 1 and Input.is_action_just_pressed("p1_throw"):
			attacking = true
			$AnimationPlayer.play("attack_anim_p1")
		if player == 2 and Input.is_action_just_pressed("p2_throw"):
			attacking = true
			$AnimationPlayer.play("attack_anim_p2")
	elif power == 2:
		if player == 1 and Input.is_action_just_pressed("p1_throw"):
			attacking = true
			$AnimationPlayer.play("attack_anim_p1_power_2")
		if player == 2 and Input.is_action_just_pressed("p2_throw"):
			attacking = true
			$AnimationPlayer.play("attack_anim_p2_power_2")
	elif power == 3:
		if player == 1 and Input.is_action_just_pressed("p1_throw"):
			reverse_gravity()
		if player == 2 and Input.is_action_just_pressed("p2_throw") and only_one_bullet == false:
			attacking = true
			$AnimationPlayer.play("attack_anim_p2_power_3")
	elif power == 4:
		if player == 1 and Input.is_action_just_pressed("p1_throw"):
			attacking = true
			$AnimationPlayer.play("attack_anim_p1_power_4")

func throw() -> void:
	if player == 1:
		if holding_object == true and Input.is_action_just_pressed("p1_throw") :
			$pick_object/CollisionShape2D.disabled = false
			object_hold.jogar_objeto(dir)
			object_hold = null
			holding_object = false
	elif player == 2:
		if holding_object == true and Input.is_action_just_pressed("p2_throw") :
			$pick_object/CollisionShape2D.disabled = false
			object_hold.jogar_objeto(dir)
			object_hold = null
			holding_object = false

func grab_object() -> void:
	if objeto_in_range != null and holding_object == false:
		if player == 1:
			if Input.is_action_just_pressed("p1_grab") and objeto_in_range.pegavel == true:
				$pick_object/CollisionShape2D.disabled = true
				holding_object = true
				objeto_in_range.agarra_objeto(self)
				object_hold = objeto_in_range
		elif player == 2:
			if Input.is_action_just_pressed("p2_grab") and objeto_in_range.pegavel == true:
				$pick_object/CollisionShape2D.disabled = true
				holding_object = true
				objeto_in_range.agarra_objeto(self)
				object_hold = objeto_in_range

func change_gravity(normal_gravity):
	if normal_gravity == true:
		$Pivot.scale.y = 1
		jump_reverse = false
		if gravity < 0:
			gravity = gravity * -1
			gravity_add = gravity_add * -1
	else:
		$Pivot.scale.y = -1
		jump_reverse = true
		velocity.y = -200
		if gravity > 0:
			gravity = gravity * -1
			gravity_add = gravity_add * -1

func reverse_gravity():
	if gravity > 0:
		change_gravity(false)
	elif gravity < 0:
		change_gravity(true)

func see_can_jump() -> void:
	if jump_reverse == false:
		if is_on_floor():
			can_jump = true
		if is_on_floor() == false and down_time == false and can_jump == true:
			down_time = true
			$Coyote_window.start()
			await $Coyote_window.timeout
			can_jump = false
			down_time = false
	elif jump_reverse == true:
		if is_on_ceiling():
			can_jump = true
		if is_on_ceiling() == false and down_time == false and can_jump == true:
			down_time = true
			$Coyote_window.start()
			await $Coyote_window.timeout
			can_jump = false
			down_time = false

func anim() -> void:
	if Input_move_vector != 0 and is_on_floor() and attacking == false:
		if player == 1:
			if power == 1:
				$AnimationPlayer.play("walking_anim_p1")
			elif power == 2:
				$AnimationPlayer.play("walking_anim_p1_power_2")
			elif power == 4:
				$AnimationPlayer.play("walking_anim_p1_power_4")
		elif player == 2:
			if power == 1:
				$AnimationPlayer.play("walking_anim_p2")
			elif power == 2:
				$AnimationPlayer.play("walking_anim_p2_power_2") 
			elif power == 3:
				$AnimationPlayer.play("walking_anim_p2_power_3")
			elif power == 4:
				$AnimationPlayer.play("walking_anim_p2_power_4")
	if Input_move_vector > 0:
		$Pivot.scale.x = 1
		dir = 1
	elif Input_move_vector < 0:
		$Pivot.scale.x = -1
		dir = -1
	if is_on_floor() == false and attacking == false:
		if player == 1:
			if power == 1:
				$AnimationPlayer.play("jump_anim_p1")
			elif power == 2:
				$AnimationPlayer.play("jump_anim_p1_power_2")
			elif power == 4:
				$AnimationPlayer.play("jump_anim_p1_power_4")
		elif player == 2:
			if power == 1:
				$AnimationPlayer.play("jump_anim_p2")
			elif power == 2:
				$AnimationPlayer.play("jump_anim_p2_power_2")
			elif power == 3:
				$AnimationPlayer.play("jump_anim_p2_power_3")
			elif power == 4:
				$AnimationPlayer.play("jump_anim_p2_power_4")
	elif Input_move_vector == 0 and attacking == false:
		if player == 1:
			if power == 1:
				$AnimationPlayer.play("Indie_anim_p1")
			elif power == 2:
				$AnimationPlayer.play("Indie_anim_p1_power_2")
			elif power == 4:
				$AnimationPlayer.play("Indie_anim_p1_power_4")
		elif player == 2:
			if power == 1:
				$AnimationPlayer.play("Indie_anim_p2")
			elif power == 2:
				$AnimationPlayer.play("Indie_anim_p2_power_2")
			elif power == 3:
				$AnimationPlayer.play("Indie_anim_p2_power_3")
			elif power == 4:
				$AnimationPlayer.play("Indie_anim_p2_power_4")
	if power == 3 and player == 1:
		if Input_move_vector == 0 and attacking == false:
			if is_on_floor() or is_on_ceiling():
				if jump_reverse == true:
					$AnimationPlayer.play("Indie_anim_p1_power_3_ligado")
				else:
					$AnimationPlayer.play("Indie_anim_p1_power_3_desligado")
			else:
				if jump_reverse == true:
					$AnimationPlayer.play("jump_anim_p1_power_3_ligado")
				else:
					$AnimationPlayer.play("jump_anim_p1_power_3_desligado")
		if Input_move_vector != 0:
			if is_on_floor() or is_on_ceiling():
				if jump_reverse == true:
					$AnimationPlayer.play("walking_anim_p1_power_3_ligado")
				else:
					$AnimationPlayer.play("walking_anim_p1_power_3_desligado")
func jump(delta) -> void:
	if jump_reverse == false:
		if player == 1:
			if Input.is_action_pressed("p1_up") and can_jump == true:
				velocity.y = JUMP_FORCE + add_vector_y * delta
				world.switch_red_()
				can_jump = false
				down_time = false
		elif  player == 2:
			if Input.is_action_pressed("p2_up") and can_jump == true:
				velocity.y = JUMP_FORCE + add_vector_y * delta
				world.switch_yellow_()
				down_time = false
				can_jump = false
	elif jump_reverse == true:
		if player == 1:
			if Input.is_action_pressed("p1_up") and can_jump == true:
				velocity.y = -JUMP_FORCE - add_vector_y * delta
				world.switch_red_()
				can_jump = false
				down_time = false
		elif  player == 2:
			if Input.is_action_pressed("p2_up") and can_jump == true:
				velocity.y = -JUMP_FORCE - add_vector_y * delta
				world.switch_yellow_()
				down_time = false
				can_jump = false


func try_walk(delta) -> void:
	if player == 1:
		if Input.is_action_pressed("p1_left"):
			Input_move_vector = -SPEED
			velocity.x = Input_move_vector + add_vector_x + belt_velocity  + vector_rigid.x * delta
		elif Input.is_action_pressed("p1_right"):
			Input_move_vector = SPEED
			velocity.x = Input_move_vector + add_vector_x + belt_velocity + vector_rigid.x * delta
		else:
			Input_move_vector = 0
			velocity.x = Input_move_vector + add_vector_x + belt_velocity + vector_rigid.x * delta
	elif player == 2:
		if Input.is_action_pressed("p2_left"): 
			Input_move_vector = -SPEED
			velocity.x = Input_move_vector + add_vector_x + belt_velocity + vector_rigid.x * delta
		elif Input.is_action_pressed("p2_right"):
			Input_move_vector = SPEED
			velocity.x = Input_move_vector + add_vector_x + belt_velocity + vector_rigid.x * delta
		else:
			Input_move_vector = 0
			velocity.x = Input_move_vector + add_vector_x + belt_velocity + vector_rigid.x * delta

func death() -> void:
	get_parent().player_dead(player)
	belt_velocity = 0
	$Pivot.visible = false
	$Sprite2D.visible = false
	self.global_position.y = -2000
	self.global_position.x = -2000
	dead = true
	var can_revive = false
	if player == 1:
		can_revive = get_parent().p1_revive()
	if player == 2:
		can_revive = get_parent().p2_revive()
	
	if can_revive == true:
		$Death_timer.start()
		if player == 1:
			self.world.player_1_death()
		elif player == 2:
			self.world.player_2_death()

func get_local_to_vaso() -> Vector2:
	return $Grab_location.global_position
func _on_force_jump_area_entered(area: Area2D) -> void:
	velocity.y = JUMP_FORCE + add_vector_y


func _on_pick_object_area_entered(area: Area2D) -> void:
	var objeto = area.get_parent()
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

func _on_death_timer_timeout() -> void:
	var alvo
	gravity_add = 0
	if player == 1:
		alvo = world.player_2
	elif player == 2:
		alvo = world.player_1
	var local = alvo.get_spawn_location()
	if local != null:
		global_position = local
		dead = false
		$Pivot.visible = true
	else:
		$Death_timer.start()
	
	world.revived(player)


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	
	if anim_name == "attack_anim_p1":
		attacking = false
	elif anim_name == "attack_anim_p2":
		attacking = false
	elif anim_name == "attack_anim_p2_power_2":
		attacking = false
	elif anim_name == "attack_anim_p1_power_2":
		attacking = false
	elif anim_name == "attack_anim_p1_power_4":
		attacking = false


func _on_audio_stream_player_finished() -> void:
	if power == 1:
		var bullet_inst = BBETA.instantiate()
		world.add_child(bullet_inst)
		bullet_inst.start(self.global_position,dir)
	elif power == 2:
		var bullet_inst = ICEB.instantiate()
		world.add_child(bullet_inst)
		bullet_inst.start(self.global_position,dir)
	elif power == 3:
		var bullet_inst = CONTROLB.instantiate()
		only_one_bullet = true
		world.add_child(bullet_inst)
		bullet_inst.start(self.global_position,dir)

func _remove_add_vector():
	if add_vector_x != 0:
		if add_vector_x > 1:
			add_vector_x = add_vector_x - 5
		elif add_vector_x < 1:
			add_vector_x = add_vector_x + 5
	if add_vector_y != 0 :
		if add_vector_y > 1:
			add_vector_y = add_vector_y - 10
		elif add_vector_y < 1:
			add_vector_y = add_vector_y + 10
func _on_explosion_death_zone_area_entered(area: Area2D) -> void:
	death()
func add_vector(x,y,timer):
	add_vector_x = x
	add_vector_y = y
	$Vector_imun.start(timer)
	vector_imun = true

func add_piston_vector(y,timer):
	add_vector_piston = y
	$Piston_imun.start()

func _on_vector_imun_timeout() -> void:
	vector_imun = false


func _on_piston_imun_timeout() -> void:
	add_vector_piston = 0


func _on_tele_timer_timeout() -> void:
	death()
