extends Node2D



var angulo = 0
var angulo_acc = 1
var cast_point
var line = false

@onready var ice_bullet = preload("res://Nodes/projetil/ice_canon_bullet.tscn")
@onready var ray = $RayCast2D
@onready var sprite = $IceWeapon
@onready var line2D = $Line2D
@onready var mira = $mira


func get_maker():
	return $Marker2D.global_position
func shoot():
	var inst = ice_bullet.instantiate()
	get_parent().get_parent().world.add_child(inst)
	inst.throw(get_maker(),mira.global_position)
func _process(delta: float) -> void:
	if line == true:
		mira.visible = true
		ray.force_raycast_update()
		if ray.is_colliding() == true:
			cast_point = to_local(ray.get_collision_point())
			line2D.points[1] = cast_point
		else:
			cast_point = ray.target_position
		line2D.points[1] = cast_point
		mira.position = cast_point
	else:
		mira.visible = false
		line2D.points[1] = Vector2.ZERO

func return_pos():
	angulo = 0
	self.rotation_degrees = angulo

func show_line():
	line = true


func hide_line():
	line = false
func show_weapon():
	sprite.visible = true
func handle_moviment(input):
	if input == false:
		angulo = angulo + angulo_acc
	else:
		angulo = angulo - angulo_acc
	var angulo = clamp(angulo,-90,25)
	self.rotation_degrees = angulo
