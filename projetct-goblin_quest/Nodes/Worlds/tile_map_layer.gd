extends TileMapLayer

# Called when the node enters the scene tree for the first time.
func _start(c_world) -> void:
	await get_tree().create_timer(0.5).timeout
	for i in self.get_children():
		i._start(c_world)
