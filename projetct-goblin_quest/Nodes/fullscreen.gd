extends Button

var full = false;

func _on_pressed() -> void:
	Global.change_screen_mode()



func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("Full"):
		Global.change_screen_mode()
