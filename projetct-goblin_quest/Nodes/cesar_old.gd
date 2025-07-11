extends CharacterBody2D

var dir = 1
var pegavel = true
var SPEED = 200
var gravity = 460
var can_change = true
var object = null

var seguir = false
var start_throw = false

var up_down_x = false
var up_down = 0
var down = true
var throw_speed = 200
var throw_dir = 1


var station_stopped = false
var station_pos = Vector2.ZERO
var station = null
func _physics_process(delta: float) -> void:
	if station_stopped == false:
		if start_throw == false:
			$hit_box/CollisionShape2D.disabled = true
			if seguir == false:
				velocity.y = gravity
				velocity.x = SPEED * dir
				anim_player()
				if is_on_wall() and can_change == true:
					change_side()
			elif seguir == true:
				if object != null:
					$AnimationPlayer.pause()
					self.global_position = object.get_local()
		else:
			if up_down_x == false:
				up_down_x = true
				up_down = -25
			down_up_change()
			$hit_box/CollisionShape2D.disabled = false
			velocity.x = throw_speed * throw_dir
			velocity.y = up_down
			if is_on_floor():
				up_down = 0
				down = true
				start_throw = false
				velocity = Vector2.ZERO
				$hit_box/CollisionShape2D.disabled = true
	elif station_stopped == true:
		self.global_position = station_pos
		velocity = Vector2.ZERO
	move_and_slide()

func down_up_change():
	if up_down_x == true:
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

func lock_out(dir_alvo) -> void:
	seguir = false
	object = null
	jogar_objeto(dir_alvo)


func jogar_objeto(dir_alvo):
	throw_speed = 1800
	throw_dir = dir_alvo
	dir = throw_dir
	start_throw = true


func agarra_objeto(n):
	self.set_collision_layer_value(2,false)
	$Hit_box_timer.start()
	seguir = true
	if station_stopped == true:
		station.off_cesar()
		station = null
		station_stopped = false

func anim_player() -> void:
	if velocity.x > 0:
		$AnimationPlayer.play("roling")
	elif velocity.x < 0:
		$AnimationPlayer.play("roling_reverse")


func change_side() -> void:
	dir = dir * -1
	can_change = false
	$Timer.start()


func _on_timer_timeout() -> void:
	can_change = true


func _on_hit_box_timer_timeout() -> void:
	self.set_collision_layer_value(2,true)


func _on_cesar_box_area_entered(area: Area2D) -> void:
	$AnimationPlayer.pause()
	station_stopped = true
	station = area.get_parent()
	station_pos = station.get_pos()
	station.in_cesar()
