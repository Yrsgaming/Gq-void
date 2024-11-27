extends RigidBody2D


@export var SPEED = 600
var being_control = false
var alive = true

func _physics_process(delta: float) -> void:
	if being_control == true:
		$AnimationPlayer.play("on")
		if Input.is_action_pressed("p2_right"):
			linear_velocity.x = SPEED
		elif Input.is_action_pressed("p2_left"):
			linear_velocity.x = -SPEED
		
		if Input.is_action_pressed("p2_up"):
			linear_velocity.y = -SPEED
		if Input.is_action_just_pressed("p2_down"):
			linear_velocity.y = SPEED
		linear_velocity.normalized()
	else:
		$AnimationPlayer.play("off")

func unlock():
	being_control = false



func _on_control_area_area_entered(area: Area2D) -> void:
	area.get_parent().dead()
	being_control = true
	get_parent().p2_lock_obj(self)
