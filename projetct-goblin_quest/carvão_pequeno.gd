extends CharacterBody2D

var dir = 1

var SPEED = 200
var gravity = 460
var can_change = true
var alive = true

func _physics_process(delta: float) -> void:
	if alive == true:
		velocity.y = gravity
		velocity.x = SPEED * dir
		anim_player()
		if is_on_wall() and can_change == true:
			change_side()
	move_and_slide()


func anim_player() -> void:
	if velocity.x > 0:
		$AnimatedSprite2D.play("Run")
		$AnimatedSprite2D.flip_h = false
	elif velocity.x < 0:
		$AnimatedSprite2D.play("Run")
		$AnimatedSprite2D.flip_h = true


func change_side() -> void:
	dir = dir * -1
	can_change = false
	$Timer.start()


func _on_timer_timeout() -> void:
	can_change = true
