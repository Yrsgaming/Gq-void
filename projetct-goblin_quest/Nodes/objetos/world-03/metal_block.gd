extends StaticBody2D

var fire = false
var alive = true

func _start(world):
	pass



func _on_iceblock_area_entered(area: Area2D) -> void:
	if fire == true:
		fire = false
		$AnimationPlayer.play("freeze")


func _on_fire_area_entered(area: Area2D) -> void:
	if fire == false:
		fire = true
		$AnimationPlayer.play("fire_mode")
