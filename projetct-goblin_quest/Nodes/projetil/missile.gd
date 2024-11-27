extends Area2D


@export var speed = 450
@export var steer_force = 30.0
var alive = true

var velocity_ = Vector2.ZERO
var acc = Vector2.ZERO
var target = null
# Called when the node enters the scene tree for the first time.

var dead = false


func start(pos,_target) -> void:
	global_transform = pos
	velocity_ = pos.x * speed
	target = _target
	$Timer.start()

func seek():
	var steer = Vector2.ZERO
	if target != null:
		var desired = (target.position - position).normalized() * speed
		steer = (desired - velocity_).normalized() * steer_force
	return steer


func _physics_process(delta: float) -> void:
	if dead == false:
		acc += seek()
		velocity_ = velocity_ + acc * delta
		velocity_ = velocity_.limit_length(speed)
		self.rotation = velocity_.angle()
		self.position = self.position + velocity_ * delta
		if $RayCast2D.is_colliding() == true:
			dead = true
			velocity_ = Vector2.ZERO
			$AnimationPlayer.play("boom")




func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "boom":
		queue_free()


func _on_timer_timeout() -> void:
	pass
