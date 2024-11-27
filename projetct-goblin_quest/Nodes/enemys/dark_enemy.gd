extends CharacterBody2D

var alive = true
var alvo = null
var speed = 350
var target_position
var vector = false

var look_at_dir
var add_vector = Vector2.ZERO
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if alvo != null:
		target_position = (alvo.global_position - self.global_position).normalized()
		if global_position.distance_to(alvo.global_position) > 3:
			velocity = target_position * speed
			look_at_dir = alvo.global_position
			look_at(look_at_dir)
	move_and_slide()


func _on_locate_enemy_area_entered(area: Area2D) -> void:
	alvo = area.get_parent()


func _on_locate_enemy_area_exited(area: Area2D) -> void:
	if alvo == area.get_parent():
		look_at(look_at_dir * -1)
		alvo = null
		velocity = Vector2.ZERO
