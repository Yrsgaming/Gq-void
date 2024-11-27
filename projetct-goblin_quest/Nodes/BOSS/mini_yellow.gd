extends CharacterBody2D


@onready var boss = get_parent().get_boss()

@export var player = 1
var SPEED = 700
var add_vec = 0
var add_vec_y = 1
var jump_x = false
func _physics_process(delta: float) -> void:
	if player == 2:
		if Input.is_action_pressed("p2_left"):
			add_vec = 1
		elif Input.is_action_pressed("p2_right"):
			add_vec = -1
		else:
			add_vec = 0
	elif player == 1:
		if Input.is_action_pressed("p1_left"):
			add_vec = 1
		elif Input.is_action_pressed("p1_right"):
			add_vec = -1
		else:
			add_vec = 0
	
	if player == 2:
		if Input.is_action_just_pressed("p2_up") and jump_x == false:
			add_vec_y = -1.5
			$jump_timer.start()
			jump_x = true
	elif player == 1:
		if Input.is_action_just_pressed("p1_up") and jump_x == false:
			add_vec_y = -1.5
			$jump_timer.start()
			jump_x = true
	$Pivot.look_at(boss.global_position)
	anim()
	var gravity_dir = boss.global_position - self.global_position
	var force_vector_x = gravity_dir.rotated(90) * add_vec / 2
	var force_vector = gravity_dir * add_vec_y
	velocity = force_vector + force_vector_x
	
	
	move_and_slide()


func anim():
	if player == 2:
		if add_vec > 0:
			$Pivot/AnimatedSprite2D.flip_h = true
			$Pivot/AnimatedSprite2D.play("run_yellow")
		elif add_vec < 0 :
			$Pivot/AnimatedSprite2D.flip_h = false
			$Pivot/AnimatedSprite2D.play("run_yellow")
		else:
			$Pivot/AnimatedSprite2D.play("Indie_yellow")
	elif player == 1:
		if add_vec > 0:
			$Pivot/AnimatedSprite2D.flip_h = true
			$Pivot/AnimatedSprite2D.play("run_red")
		elif add_vec < 0 :
			$Pivot/AnimatedSprite2D.flip_h = false
			$Pivot/AnimatedSprite2D.play("run_red")
		else:
			$Pivot/AnimatedSprite2D.play("Indie_red")
func _on_jump_timer_timeout() -> void:
	add_vec_y = 1
	$jump_cooldown.start()


func _on_jump_cooldown_timeout() -> void:
	jump_x = false
