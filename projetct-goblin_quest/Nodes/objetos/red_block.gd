extends Node2D

var world
# Called when the node enters the scene tree for the first time.
func _start(_world) -> void:
	world = _world
	


func _process(delta: float) -> void:
	if world != null:
		if world.red_ == false:
			$StaticBody2D/CollisionShape2D.disabled = true
			$Sprite2D.frame = 1
		else:
			$StaticBody2D/CollisionShape2D.disabled = false
			$Sprite2D.frame = 0
