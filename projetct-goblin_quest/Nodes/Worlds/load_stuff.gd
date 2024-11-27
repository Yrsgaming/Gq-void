extends Node2D


# Called when the node enters the scene tree for the first time.
func _start() -> void:
	for i in self.get_children():
		i._start()
