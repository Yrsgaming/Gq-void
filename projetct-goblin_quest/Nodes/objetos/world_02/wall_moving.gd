extends Node2D

@export var limit_top = 600
@export var limit_down = -600
@export var speed = 6
@export var top_or_down = false
var stop_gear = false
var pos_y_inicial = 0
var add_pos_y = 1
func _ready() -> void:
	pos_y_inicial = self.position.y



func _process(delta: float) -> void:
	if stop_gear == false:
		position.y = pos_y_inicial + add_pos_y
		if top_or_down == false:
			if add_pos_y < limit_top:
				$AnimationPlayer.play("rot")
				add_pos_y = add_pos_y + speed
			else:
				$AnimationPlayer.pause()
		if top_or_down == true:
			if add_pos_y > limit_down:
				$AnimationPlayer.play_backwards("rot")
				add_pos_y = add_pos_y - speed
			else:
				$AnimationPlayer.pause()
	else:
		$CentralGear.frame = 1
		$AnimationPlayer.pause()


func _on_area_2d_area_entered(area: Area2D) -> void:
	$CentralGear.frame = 0
	stop_gear = false
	if top_or_down == false:
		top_or_down = true
	elif top_or_down == true:
		top_or_down = false


func stop():
	stop_gear = true
