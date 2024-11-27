extends Node2D

var start = false


func start_light():
	if start == false:
		start = true
		for i in (self.get_child_count() - 1):
			self.get_child(i + 1).light_up()
			await get_tree().create_timer(0.15).timeout
