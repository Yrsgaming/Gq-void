extends Node2D

@onready var world = get_parent().get_parent()
var vasos_max
var start = false
var layer = null
var off_cooldown = true
const vaso = preload("res://Nodes/objetos/vaso.tscn")


func _start() -> void:
	$load.start()




func _on_load_timeout() -> void:
	vasos_max = world.vasos
	start = true

func _physics_process(delta: float) -> void:
	if start == true:
		if vasos_max > world.vasos and off_cooldown == true:
			print(vasos_max, world.vasos)
			off_cooldown = false
			$cooldown.start()
			var vaso_inst = vaso.instantiate()
			vaso_inst.global_position.x = $Sprite2D.global_position.x
			vaso_inst.global_position.y = $Sprite2D.global_position.y
			vaso_inst.scale = Vector2(10,10)
			vaso_inst.start_filho(get_parent().get_parent())
			get_parent().add_child(vaso_inst)


func _on_cooldown_timeout() -> void:
	off_cooldown = true
