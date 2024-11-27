extends Node2D


var world
var start = false
# Called when the node enters the scene tree for the first time.
func _start(_world) -> void:
	world = _world
	start = true


func _process(delta: float) -> void:
	if start == true:
		if world.blue_ == false:
			$StaticBody2D/CollisionShape2D.disabled = true
			$BlueZone.frame = 1
		else:
			$StaticBody2D/CollisionShape2D.disabled = false
			$BlueZone.frame = 0
