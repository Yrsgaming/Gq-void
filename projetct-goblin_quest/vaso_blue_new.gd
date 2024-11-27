extends RigidBody2D

#region 
var pegavel = true
var throw_strengh = 2000.0
var held = false
var player = null
var player_grab = null
var stun = false
var local_inicial = Vector2.ZERO
#endregion


func _ready() -> void:
	local_inicial = self.global_position





func _physics_process(delta: float) -> void:
	if stun == true:
		self.freeze = true
		linear_velocity = Vector2.ZERO
	if held == true:
		global_position = player.get_local_to_vaso()


func jogar_objeto(dir_X):
	$Area2D/CollisionShape2D.disabled = false
	$Timer.start(1)
	linear_velocity = Vector2(dir_X,0) * throw_strengh
	self.freeze = false
	held = false

func agarra_objeto(player_):
	linear_velocity = Vector2.ZERO
	player = player_
	held = true
	self.freeze = true




func _on_timer_timeout() -> void:
	$Area2D/CollisionShape2D.disabled = true


func _on_hurt_box_area_entered(area: Area2D) -> void:
	if area.get_parent() != self:
		stun = true
		$AnimationPlayer.play("shoosh")
		self.global_position = local_inicial
		$AnimationPlayer.play("anim")
		await $AnimationPlayer.animation_finished
		stun = false
		self.freeze = false
