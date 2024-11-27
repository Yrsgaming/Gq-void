extends CharacterBody2D

var dir = 1
var SPEED = 1800
var up_down = 0
var up_down_start = false
var start = false
var down = true

var stun = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if is_on_floor():
		up_down = 0
		down = true
		start = false
		velocity = Vector2.ZERO
		$Area2D/CollisionShape2D.disabled = true
	if is_on_wall():
		SPEED = 0
	if start == true:
		if up_down_start == false:
			up_down_start = true
			up_down = -25
		down_up_change()
		$Area2D/CollisionShape2D.disabled = false
		velocity.x = SPEED * dir * 60 * delta 
		velocity.y = up_down * 60 * delta 
	else:
		velocity.y = 600
	if stun == false:
		move_and_slide()
	else:
		up_down = 0
		down = true
		start = false
		velocity = Vector2.ZERO
		$Area2D/CollisionShape2D.disabled = true

func throw_away(dir_alvo):
	SPEED = 1800
	dir = dir_alvo
	start = true


func down_up_change():
	if up_down_start == true:
		if down == true:
			if up_down > -350:
				up_down = up_down - 100
			else:
				down = false
				up_down_change()
		else:
			up_down_change()
	

func up_down_change() -> void:
	if up_down != 600:
		up_down = up_down + 50
