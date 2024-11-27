extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_entered(area: Area2D) -> void:
	var P = area.get_parent().player
	if P == 1:
		self.get_parent().p1_dark_zone()
	elif P == 2:
		self.get_parent().p2_dark_zone()


func _on_area_exited(area: Area2D) -> void:
	var P = area.get_parent().player
	if P == 1:
		self.get_parent().p1_out_dark_zone()
	elif P == 2:
		self.get_parent().p2_out_dark_zone()
