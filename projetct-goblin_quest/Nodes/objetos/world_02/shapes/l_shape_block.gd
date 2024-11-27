extends RigidBody2D

var world = null
var start = false
var ritmo = null
var alive = true
var speed = 10000
var speed_multi = 1
var dir = 1
var on = true
var is_burn = false
var is_crunch = false
func _start_inst(_world,global_pos,_dir):
	dir = _dir
	self.global_position = global_pos
	world = _world
	speed_multi = world.piece_belt_velocity
	ritmo = world.belt_ritmo
	start = true
	$Timer.start(ritmo)

func crush():
	is_crunch = true
	self.rotation = 0
	if is_burn == false:
		$AnimationPlayer.play("crunch")
	else:
		$AnimationPlayer.play("burn_crush")
func death():
	queue_free()

func burn():
	if is_burn == false and is_crunch == false:
		$AnimationPlayer.play("Burn")
		is_burn = true
func _physics_process(delta: float) -> void:
	if world.belt_sempre_on == false:
		if on == true and start == true:
			linear_velocity.x = speed * dir * speed_multi * delta
	else:
		linear_velocity.x = speed * dir * speed_multi * delta

func _on_timer_timeout() -> void:
	if on == true:
		on = false
	else:
		on = true
