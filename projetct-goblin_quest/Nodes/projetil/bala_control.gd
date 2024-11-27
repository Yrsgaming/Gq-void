extends CharacterBody2D

var dir = 1
var SPEED = 1500
var bstart = false



func _physics_process(delta: float) -> void:
	
	velocity.x = SPEED * dir
	
	if velocity.x < 0:
		$Sprite2D.flip_h = true
	if $wall_check.is_colliding():
		death()
	move_and_slide()

func start(pos,dir_) -> void:
	if bstart == false:
		self.global_position = pos
		dir = dir_
		bstart = true

func death():
	SPEED = 0
	dir = 0
	get_parent().remove_p2_only_bullet()
	$Sprite2D.visible = false
	$CPUParticles2D.emitting = false
	$AnimationPlayer.play("colission_off")
	$Timer.start($CPUParticles2D.lifetime)



func _on_visible_on_screen_enabler_2d_screen_exited() -> void:
	death()

func dead():
	death()
func _on_hit_box_enemy_area_entered(area: Area2D) -> void:
	death()


func _on_timer_timeout() -> void:
	queue_free()
