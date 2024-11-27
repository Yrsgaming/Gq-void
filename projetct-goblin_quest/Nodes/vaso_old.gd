extends Node2D

var pegavel = true
var object = null
var seguir = false
var throw = false

var dir = Vector2.ZERO



func _ready() -> void:
	get_parent().get_parent().add_vaso_count()
func _physics_process(delta: float) -> void:
	if seguir == true:
		
		if object != null:
			var vaso_selecionado = object.get_object_in_range()
			if vaso_selecionado != self and $CharacterBody2D/RayCast2D.is_colliding() == false:
				get_child(0).global_position = object.get_local()

func agarra() -> void:
	$CharacterBody2D.set_collision_layer_value(2,false)
	$Timer.start()
	seguir = true


func lock_out(dir_alvo) -> void:
	seguir = false
	object = null
	$CharacterBody2D.throw_away(dir_alvo)


func _on_timer_timeout() -> void:
	$CharacterBody2D.set_collision_layer_value(2,true)


func _on_hurt_box_area_entered(area: Area2D) -> void:
	if area.get_parent() != $CharacterBody2D:
		get_parent().get_parent().remove_vasos()
		queue_free()
