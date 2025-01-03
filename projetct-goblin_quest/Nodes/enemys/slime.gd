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
