extends AnimatableBody2D

var alive = true
var world = null
var start = false
var ritmo = null

func _start(_world):
	world = _world
	ritmo = world.belt_ritmo
	start = true
	$Timer.start(ritmo)




func _on_hurt_box_area_entered(area: Area2D) -> void:
	print("try")
	if area.get_parent().get_child(0).name == "LPiece":
		area.get_parent().crush()


func _on_timer_timeout() -> void:
	$AnimationPlayer.play("CRUNCH")
	$Timer.start(ritmo)


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "CRUNCH":
		$AnimationPlayer.play("RESET")
