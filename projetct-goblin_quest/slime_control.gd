extends CharacterBody2D

var dir = 1

var SPEED = 200
var gravity = 460
var scale_speed = 60
var can_change = true
var alive = true
var being_control = false
func _physics_process(delta: float) -> void:
	if being_control == false:
		$AnimationPlayer.play("off")
		if alive == true:
			anim_player()
			velocity.y = scale_speed * gravity * delta
			velocity.x = scale_speed * SPEED * dir * delta
			if is_on_wall() and can_change == true:
				change_side()
	elif being_control == true:
		$AnimationPlayer.play("on")
		if Input.is_action_pressed("p2_right"):
			$AnimatedSprite2D.play("control_walk")
			velocity.x = SPEED * scale_speed * delta
			$AnimatedSprite2D.flip_h = false
		elif Input.is_action_pressed("p2_left"):
			$AnimatedSprite2D.play("control_walk")
			velocity.x = -SPEED * scale_speed * delta
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.play("Indie_control")
			velocity.x = 0
	move_and_slide()


func anim_player() -> void:
	if being_control == false:
		if velocity.x > 0:
			$AnimatedSprite2D.play("off_control_walk")
			$AnimatedSprite2D.flip_h = false
		elif velocity.x < 0:
			$AnimatedSprite2D.play("off_control_walk")
			$AnimatedSprite2D.flip_h = true
func change_side() -> void:
	dir = dir * -1
	can_change = false
	$Timer.start()


func _on_timer_timeout() -> void:
	can_change = true


func _on_hurtbox_area_entered(area: Area2D) -> void:
	alive = false
	velocity = Vector2.ZERO
	self.set_collision_layer_value(2,false)
	$Hitbox/CollisionShape2D.disabled = true
	$Hurtbox/CollisionShape2D.disabled = true
	$AnimatedSprite2D.visible = false
	$CPUParticles2D.emitting = true
	$CPUParticles2D2.emitting = true
	$CPUParticles2D3.emitting = true
	await get_tree().create_timer(0.4).timeout
	queue_free()



func unlock():
	being_control = false



func _on_control_area_area_entered(area: Area2D) -> void:
	area.get_parent().dead()
	being_control = true
	get_parent().p2_lock_obj(self)
