extends Node2D


var world = null
var start = false
var ritmo = null


var lazer_on = true
func _start(_world):
	world = _world
	ritmo = world.belt_ritmo
	start = true
	$Timer.start(ritmo)

func _physics_process(delta: float) -> void:
	if start == true:
		if lazer_on == true:
			var cast_point = null
			$RayCast2D.force_raycast_update()
			
			if $RayCast2D.is_colliding() == true:
				cast_point = to_local($RayCast2D.get_collision_point())
				if $RayCast2D.get_collider().name == "Player":
					$RayCast2D.get_collider().death()
				elif $RayCast2D.get_collider().name == "Player2":
					$RayCast2D.get_collider().death()
				elif $RayCast2D.get_collider().get_child(0).name == "LPiece":
					$RayCast2D.get_collider().burn()
			$Line2D.points[1] = cast_point



func on():
	var tween = create_tween()
	tween.tween_property($Line2D,"width",10.0,0.2)

func off():
	var tween = create_tween()
	tween.tween_property($Line2D,"width",0,0.2)

func _on_timer_timeout() -> void:
	print("try_change",lazer_on)
	if lazer_on == true:
		lazer_on = false
		off()
		$Timer.start(ritmo)
	elif lazer_on == false:
		lazer_on = true
		on()
		$Timer.start(ritmo)
