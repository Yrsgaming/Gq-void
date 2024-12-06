extends RigidBody2D


var SPEED = 100000
var veloc = Vector2.ZERO
var dead = false
var temp_red = -40
func throw(pos,point):
	$AnimationPlayer.play("flying")
	self.global_position = pos
	var vector = position.direction_to(point)
	veloc = vector


func _physics_process(delta: float) -> void:
	if dead == false:
		linear_velocity = veloc * SPEED * delta
		if $wall_check.is_colliding():
			boom()
		if $wall_check2.is_colliding():
			boom()
		if $wall_check3.is_colliding():
			boom()
		if $wall_check4.is_colliding():
			boom()

func boom():
	dead = true
	$AnimationPlayer.play("boom")
	linear_velocity = Vector2.ZERO
