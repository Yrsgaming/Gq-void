extends CharacterBody2D

@export var player = 1
var SPEED = 620
var actived = false

var can_jump = false
var down_time = false
var JUMP_FORCE = -1150
var gravity = 46
var gravity_add = 0




func _ready() -> void:
	if player == 1:
		$Pivot/p2.visible = false
	elif player == 2:
		$Pivot/p1.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if is_on_floor() == false:
		gravity_add = gravity_add + gravity
		velocity.y = velocity.y + gravity
	else:
		gravity_add = gravity
	
	
	
	if actived == true:
		if velocity.x != 0:
			$AnimationPlayer.play("run")
		else:
			$AnimationPlayer.play("RESET")
		if velocity.x > 0:
			$Pivot.scale.x = 1
		elif velocity.x < 0:
			$Pivot.scale.x = -1
		
		force_jump()
		see_can_jump()
		jump()
		try_walk()
	else:
		$AnimationPlayer.play("deactived")
		if get_parent().blue_ == true:
			actived = true
	move_and_slide()

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

func jump() -> void:
	if player == 1:
		if Input.is_action_pressed("p1_up") and can_jump == true:
			velocity.y = JUMP_FORCE
			can_jump = false
			down_time = false
	elif  player == 2:
		if Input.is_action_pressed("p2_up") and can_jump == true:
			velocity.y = JUMP_FORCE
			down_time = false
			can_jump = false


func see_can_jump() -> void:
	if is_on_floor():
		can_jump = true
	if is_on_floor() == false and down_time == false and can_jump == true:
		down_time = true
		$Coyote_window.start()
		await $Coyote_window.timeout
		can_jump = false
		down_time = false

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
