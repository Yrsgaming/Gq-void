extends Node2D
var alvo

func _start() -> void:
	if get_parent().player_1 != null:
		alvo = get_parent().player_1
	else:
		await get_tree().create_timer(0.2).timeout
		alvo = get_parent().player_1

func _physics_process(delta: float) -> void:
	if alvo != null:
		self.position.x = alvo.position.x
		self.position.y = alvo.position.y
	else:
		pass

func set_limit(limit_left,limit_right,limit_top,limit_bottom):
	$Camera2D.limit_left = limit_left
	$Camera2D.limit_right = limit_right
	$Camera2D.limit_top = limit_top
	$Camera2D.limit_bottom = limit_bottom
