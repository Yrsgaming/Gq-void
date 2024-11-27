extends Node2D
@export var light_id = 0

var world = null
func _ready() -> void:
	world = get_parent()
func _on_area_2d_area_entered(area: Area2D) -> void:
	$Sprite2D.frame = 1
	world.break_light(light_id)
