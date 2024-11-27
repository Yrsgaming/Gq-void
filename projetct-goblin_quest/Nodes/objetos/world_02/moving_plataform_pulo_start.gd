extends Path2D

@export var loop = false
@export var speed = 2.0
@export var speed_scale  = 1.0
var start = false
# Called when the node enters the scene tree for the first time.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if start == true:
		
		
		
		if loop == false:
			$AnimationPlayer.play("move")
			$AnimationPlayer.speed_scale = speed_scale
			set_process(false)

func change_dir():
	speed_scale = speed_scale *-1
	speed = speed *-1
	$AnimationPlayer.speed_scale = speed_scale


func _on_area_2d_area_entered(area: Area2D) -> void:
	start = true


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	start = false
