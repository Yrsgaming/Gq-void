extends Path2D

const PLATAFORM_ICE = preload("res://Nodes/objetos/world-03/ice_plataform.tscn")
var plataform_atual = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var plataform_inst = PLATAFORM_ICE.instantiate()
	self.add_child(plataform_inst)
	$PathFollow2D/RemoteTransform2D.remote_path = plataform_inst.get_path()
	$AnimationPlayer.play("go")
	plataform_atual = plataform_inst
	plataform_inst.P_show()



func new_plataform():
	$AnimationPlayer.stop()
	plataform_atual.queue_free()
	var plataform_inst = PLATAFORM_ICE.instantiate()
	$AnimationPlayer.play("RESET")
	self.add_child(plataform_inst)
	$PathFollow2D/RemoteTransform2D.remote_path = plataform_inst.get_path()
	plataform_atual = plataform_inst
	$AnimationPlayer.play("go")
	plataform_inst.P_show()
