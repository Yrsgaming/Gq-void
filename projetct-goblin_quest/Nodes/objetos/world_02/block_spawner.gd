extends StaticBody2D

var world = null
var start = false
var ritmo = null
var open = false
@export var dir = 1
var L_shape = preload("res://Nodes/objetos/world_02/shapes/l_shape_block.tscn")
var box_shape = preload("res://Nodes/objetos/world_02/shapes/t_shape.tscn")
var T_reverse_shape = preload("res://Nodes/objetos/world_02/shapes/t_reverse_shape.tscn")
var rng = RandomNumberGenerator.new()
func _start(_world):
	world = _world
	ritmo = world.belt_ritmo
	start = true
	$Timer.start(ritmo)


func create_piece():
	var RNG_NUMBER = int(rng.randf_range(1,4))
	var piece_inst 
	if RNG_NUMBER == 1:
		piece_inst = box_shape.instantiate()
	elif RNG_NUMBER == 2:
		piece_inst = T_reverse_shape.instantiate()
	elif RNG_NUMBER == 3:
		piece_inst = L_shape.instantiate()
		
	world.add_child(piece_inst)
	piece_inst._start_inst(world,$Marker2D.global_position,dir)
func _on_timer_timeout() -> void:
	if open == false:
		$AnimationPlayer.play("on")
		$Timer.start(ritmo)
		open = true
	else:
		$AnimationPlayer.play("close")
		$Timer.start(ritmo)
		open = false


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "on":
		create_piece()
