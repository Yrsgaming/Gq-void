extends CharacterBody2D

var dir = 1

var SPEED = 50
var gravity = 460
var can_change = true
var alive = true
var burn = false
func _physics_process(delta: float) -> void:
	if alive == true:
		velocity.y = gravity
		velocity.x = SPEED * dir
		anim_player()
		if is_on_wall() and can_change == true:
			change_side()
	move_and_slide()


func anim_player() -> void:
	if burn == false:
		if velocity.x > 0:
			$AnimationPlayer.play("walk_no_burn")
			$Sprite2D.flip_h = true
		elif velocity.x < 0:
			$AnimationPlayer.play("walk_no_burn")
			$Sprite2D.flip_h = false
	if burn == true:
		if velocity.x > 0:
			$AnimationPlayer.play("walk_burn")
			$Sprite2D.flip_h = true
		elif velocity.x < 0:
			$AnimationPlayer.play("walk_burn")
			$Sprite2D.flip_h = false

func change_side() -> void:
	dir = dir * -1
	can_change = false
	$Timer.start()


func _on_timer_timeout() -> void:
	can_change = true


func _on_fire_camada_area_entered(area: Area2D) -> void:
	burn = true

func _on_ice_camada_area_entered(area: Area2D) -> void:
	burn = false
