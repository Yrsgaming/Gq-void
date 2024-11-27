extends StaticBody2D


var target = null
const missil = preload("res://Nodes/projetil/missile.tscn")
var world = null
var is_ready = true


func _ready() -> void:
	world = get_parent().get_parent()
func _start(_world):
	world = _world
func _process(delta: float) -> void:
	if is_ready == true:
		if $RayCast2D.is_colliding() == true:
			target = $RayCast2D.get_collider().get_parent()
			$AnimationPlayer.play("missile")
		elif $RayCast2D2.is_colliding() == true:
			target = $RayCast2D2.get_collider().get_parent()
			$AnimationPlayer.play("missile")
		elif $RayCast2D3.is_colliding() == true:
			target = $RayCast2D3.get_collider().get_parent()
			$AnimationPlayer.play("missile")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "missile":
		$Missle.visible = false
		is_ready = false
		var bullet_inst = missil.instantiate()
		world.add_child(bullet_inst)
		bullet_inst.start($Marker2D.global_transform,target)
		target = null
		$Timer.start()
	elif anim_name == "missile_ready":
		is_ready = true


func _on_timer_timeout() -> void:
	$AnimationPlayer.play("missile_ready")
