extends StaticBody2D

var move_dir = 400
var ritmo = null
var speed_scale = 1
var on = false
var world = null
func _start(_world) -> void:
	ritmo = _world.belt_ritmo
	speed_scale = _world.piece_belt_velocity
	world = _world
	$Timer.start(ritmo)
	if on == true:
		move_dir = -150 * speed_scale
		$AnimatedSprite2D.play_backwards("default")
	else:
		move_dir = 0
		$AnimatedSprite2D.pause()


func _on_timer_timeout() -> void:
	if world.belt_sempre_on == false:
		if on == true:
			on = false
			move_dir = 0
			$AnimatedSprite2D.pause()
		else:
			on = true
			move_dir = -150 * speed_scale
			$AnimatedSprite2D.play_backwards("default")
	else:
			move_dir = -150 * speed_scale
			$AnimatedSprite2D.play_backwards("default")
	$Timer.start()
