extends CharacterBody2D

var dir = 1

var SPEED = 200
var gravity = 460
var scale_speed = 60
var can_change = true
var alive = true
var being_control = false
var can_move = true
var jump = 50000
func _physics_process(delta: float) -> void:
	if can_move:
		if being_control == false:
			if alive == true:
				anim_player()
				velocity.y = scale_speed * gravity * delta
				velocity.x = scale_speed * SPEED * dir * delta
				if is_on_wall() and can_change == true:
					change_side()
		elif being_control == true:
			if Input.is_action_pressed("p2_right"):
				$AnimationPlayer2.play("walk_control")
				velocity.x = SPEED * scale_speed * delta
				$Sprite2D.flip_h = false
			elif Input.is_action_pressed("p2_left"):
				$AnimationPlayer2.play("walk_control")
				velocity.x = -SPEED * scale_speed * delta
				$Sprite2D.flip_h = true
			else:
				$AnimationPlayer2.play("Indie")
				velocity.x = 0
			if Input.is_action_just_pressed("p2_up") and is_on_floor():
				velocity.y = -jump* delta
			if is_on_floor() == false:
				if velocity.y < 500:
					velocity.y = velocity.y + 50
			if Input.is_action_just_pressed("p2_throw"):
				$AnimationPlayer2.play("_to_boom")
				$CPUParticles2D4.emitting = true
				can_move = false
	else:
		velocity = Vector2.ZERO
	move_and_slide()


func anim_player() -> void:
	if being_control == false:
		if velocity.x != 0:
			$AnimationPlayer2.play("walk")
			if velocity.x > 0:
				$Sprite2D.flip_h = false
			else:
				$Sprite2D.flip_h = true


func change_side() -> void:
	dir = dir * -1
	can_change = false
	$Timer.start()


func _on_timer_timeout() -> void:
	can_change = true


func _on_hurtbox_area_entered(area: Area2D) -> void:
	$AnimationPlayer2.play("boom")



func unlock():
	being_control = false



func _on_control_area_area_entered(area: Area2D) -> void:
	area.get_parent().dead()
	being_control = true
	get_parent().p2_lock_obj(self)


func _on_animation_player_2_animation_finished(anim_name: StringName) -> void:
	if anim_name == "boom":
		unlock()
		get_parent().p2_unlock()
		queue_free()
	elif anim_name == "_to_boom":
		$AnimationPlayer2.play("boom")
