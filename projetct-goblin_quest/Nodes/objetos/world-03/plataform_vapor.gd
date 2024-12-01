extends Node2D

@export var temp = 0.0

var temp_limit_top = 50.0
var modulate_valor = 1
var heating = false
func _process(delta: float) -> void:
	$CPUParticles2D.gravity.y = (temp * -24) + 15
	if temp > 1.0:
		$AnimationPlayer.play("up_down")
	else:
		$AnimationPlayer.play("RESET")
	if heating == true:
		$Pivot_plataform.position.y = temp * -1
		modulate_valor = modulate_valor - 0.01
		$Ball2.modulate.a = modulate_valor
		temp = temp + 0.2
		if temp > temp_limit_top:
			temp = temp_limit_top


func move_pivot(pos):
	var tween = create_tween()
	tween.tween_property($Pivot_plataform , "position" ,Vector2(0,pos),0.2)
	await get_tree().create_timer(0.2).timeout 
func _on_temp_up_area_entered(area: Area2D) -> void:
	heating = true
	

func _on_temp_down_area_entered(area: Area2D) -> void:
	temp = temp - 15.0
	if temp < 0:
		temp = 0
	move_pivot(temp * -1)


func _on_temp_up_area_exited(area: Area2D) -> void:
	heating = false
