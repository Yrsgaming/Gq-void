extends Node2D

var world
func _start(_world) -> void:
	world = _world

func in_cesar():
	world.on_blue()


func get_pos():
	return self.global_position
func off_cesar():
	world.off_blue()
