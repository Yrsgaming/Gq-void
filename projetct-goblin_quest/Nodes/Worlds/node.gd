extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.play("default")
	$AnimatedSprite2D2.play("default2")
