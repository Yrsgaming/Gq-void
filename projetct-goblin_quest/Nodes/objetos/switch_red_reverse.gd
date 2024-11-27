extends Node2D


var world
var start = false
# Called when the node enters the scene tree for the first time.
func _start(_world) -> void:
	world = _world
	start = true


func _process(delta: float) -> void:
	if start == true:
		if world.switch_red == true:
			$StaticBody2D/CollisionShape2D.disabled = true
			$Sprite2D.frame = 1
		else:
			$StaticBody2D/CollisionShape2D.disabled = false
			$Sprite2D.frame = 0
