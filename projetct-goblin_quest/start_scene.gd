extends Node2D


var start_level = "res://Nodes/Worlds/world_01.tscn"

var p1_config_x = 0
var p1_config_start = false
@onready var p_2_config: Button = $"button_sutff/p2 CONFIG"

var p2_config_start = false
var p2_config_x = 0
var Input_can_count = true

func _ready() -> void:
	$Camera2D.change_scene(1)
	apply_input_config("1")
	apply_input_config("2")

func apply_input_config(player_id):
	var actions = [
		"up", "left", "right", "grab", "throw", "teleport", "flag"
	]
	
	for action in actions:
		var input_var_name = "input_%s_%s" % [player_id, action]
		var action_name = "%s_%s" % [player_id, action]
		var label_path = "button_sutff/%s CONFIG/Label_%s" % [player_id, action]

		var input_event = SystemConfig.get(input_var_name)
		if input_event != null:
			InputMap.action_erase_events(action_name)
			InputMap.action_add_event(action_name, input_event)
			get_node(label_path).text = input_event.as_text()











func _input(event: InputEvent) -> void:
	if event is InputEventKey or event is InputEventJoypadButton:
		if Input_can_count == true:
			Input_can_count = false
			$"button_sutff/P1 CONFIG/Input_delay".start()
			if p1_config_start == true:
				if p1_config_x == 0:
					InputMap.action_erase_events("p1_up")
					InputMap.action_add_event("p1_up",event)
					$"button_sutff/P1 CONFIG/Label_up".text = event.as_text()
					SystemConfig.input_p1_up = event
					p1_config_x = 1
				elif p1_config_x == 1:
					InputMap.action_erase_events("p1_left")
					InputMap.action_add_event("p1_left",event)
					$"button_sutff/P1 CONFIG/Label_left".text = event.as_text()
					SystemConfig.input_p1_left = event
					p1_config_x = 2
				elif p1_config_x == 2:
					InputMap.action_erase_events("p1_right")
					InputMap.action_add_event("p1_right",event)
					$"button_sutff/P1 CONFIG/Label_right".text = event.as_text()
					SystemConfig.input_p1_right = event
					p1_config_x = 3
				elif p1_config_x == 3:
					InputMap.action_erase_events("p1_grab")
					InputMap.action_add_event("p1_grab",event)
					$"button_sutff/P1 CONFIG/Label_grab".text = event.as_text()
					SystemConfig.input_p1_grab = event
					p1_config_x = 4
				elif p1_config_x == 4:
					InputMap.action_erase_events("p1_throw")
					InputMap.action_add_event("p1_throw",event)
					SystemConfig.input_p1_throw = event
					$"button_sutff/P1 CONFIG/Label_throw".text = event.as_text()
					p1_config_x = 5
				elif p1_config_x == 5:
					InputMap.action_erase_events("p1_change_flag")
					InputMap.action_add_event("p1_change_flag",event)
					SystemConfig.input_p1_flag = event
					$"button_sutff/P1 CONFIG/Label_camera".text = event.as_text()
					p1_config_x = 6
				elif p1_config_x == 6:
					InputMap.action_erase_events("p1_teleport")
					InputMap.action_add_event("p1_teleport",event)
					SystemConfig.input_p1_teleport = event
					$"button_sutff/P1 CONFIG/Label_teleport".text = event.as_text()
					p1_config_x = 0
					p1_config_start = false
					Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
					$"button_sutff/P1 CONFIG".disabled = false
			
			
			
			elif p2_config_start == true:
				if p2_config_x == 0:
					InputMap.action_erase_events("p2_up")
					InputMap.action_add_event("p2_up",event)
					SystemConfig.input_p2_up = event
					$"button_sutff/p2 CONFIG/Label_up".text = event.as_text()
					p2_config_x = 1
				elif p2_config_x == 1:
					InputMap.action_erase_events("p2_left")
					InputMap.action_add_event("p2_left",event)
					SystemConfig.input_p2_left = event
					$"button_sutff/p2 CONFIG/Label_left".text = event.as_text()
					p2_config_x = 2
				elif p2_config_x == 2:
					InputMap.action_erase_events("p2_right")
					InputMap.action_add_event("p2_right",event)
					SystemConfig.input_p2_right = event
					$"button_sutff/p2 CONFIG/Label_right".text = event.as_text()
					p2_config_x = 3
				elif p2_config_x == 3:
					InputMap.action_erase_events("p2_grab")
					InputMap.action_add_event("p2_grab",event)
					SystemConfig.input_p2_grab = event
					$"button_sutff/p2 CONFIG/Label_grab".text = event.as_text()
					p2_config_x = 4
				elif p2_config_x == 4:
					InputMap.action_erase_events("p2_throw")
					InputMap.action_add_event("p2_throw",event)
					SystemConfig.input_p2_throw = event
					$"button_sutff/p2 CONFIG/Label_throw".text = event.as_text()
					p2_config_x = 5
				elif p2_config_x == 5:
					InputMap.action_erase_events("p2_change_flag")
					InputMap.action_add_event("p2_change_flag",event)
					SystemConfig.input_p2_flag = event
					$"button_sutff/p2 CONFIG/Label_camera".text = event.as_text()
					p2_config_x = 6
				elif p2_config_x == 6:
					InputMap.action_erase_events("p2_teleport")
					InputMap.action_add_event("p2_teleport",event)
					SystemConfig.input_p2_teleport = event
					$"button_sutff/p2 CONFIG/Label_teleport".text = event.as_text()
					p2_config_x = 0
					p2_config_start = false
					Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
					$"button_sutff/p2 CONFIG".disabled = false
func _on_p_1_config_button_down() -> void:
	$"button_sutff/P1 CONFIG".disabled = true
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	p1_config_x = 0
	p1_config_start = true
	


func _on_input_delay_timeout() -> void:
	Input_can_count = true


func _on_baack_pressed() -> void:
	$Camera2D.change_scene(1)


func _on_go_input_pressed() -> void:
	$Camera2D.change_scene(2)


func _on_p_2_config_pressed() -> void:
	$"button_sutff/p2 CONFIG".disabled = true
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	p2_config_x = 0
	p2_config_start = true


func _on_start_pressed() -> void:
	get_tree().change_scene_to_file(start_level)
