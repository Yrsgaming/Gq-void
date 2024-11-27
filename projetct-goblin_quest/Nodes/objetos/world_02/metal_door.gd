extends StaticBody2D

@export var light_id = 0
var start = false
func _process(delta: float) -> void:
	if get_parent().check_light(light_id) == false and start == false:
		start = true
		$AnimationPlayer.play("OPEN")
