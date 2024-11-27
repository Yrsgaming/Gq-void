extends CharacterBody2D
@export var dir = 1
@export var await_timer = 2.0
@export var moving_timer = 3.0


var gravity = 250
var moving = false
var gravity_add= 0
@export var SPEED = 6200
var freeze = false


func _ready() -> void:
	$Vaso_amarelo_new/AnimationPlayer.play("RESET")
func _start(world) -> void:
	$Vaso_amarelo_new/AnimationPlayer.play("off")
	$Timer.start(await_timer)



func _physics_process(delta: float) -> void:
	if freeze == false:
		$Vaso_amarelo_new.freeze = true
		if dir == 1:
			$Sprite2D.flip_h = false
		elif dir == -1:
			$Sprite2D.flip_h = true
		if is_on_floor():
			gravity_add = 0
			if moving == true:
				velocity.x = SPEED * dir * delta
				$AnimationPlayer.play("walking")
			else:
				$AnimationPlayer.play("Indie")
				velocity.x = 0
		else:
			gravity_add = gravity_add + gravity * delta
			velocity.y = gravity_add
			$AnimationPlayer.play("fall")
		
		move_and_slide()





func _on_timer_timeout() -> void:
	moving = true
	$walking_timer.start(moving_timer)
	dir = dir *-1


func _on_walking_timer_timeout() -> void:
	moving = false
	$Timer.start(await_timer)


func _on_area_2d_area_entered(area: Area2D) -> void:
	freeze = true
	$Vaso_amarelo_new/AnimationPlayer.play("on")
