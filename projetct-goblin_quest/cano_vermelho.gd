extends Node2D

var world = null
var cano_red = false



func _start(_world):
	world = _world
func _process(delta: float) -> void:
	if world != null:
		cano_red = world.cano_red
		if cano_red == false:
			on()
		else:
			off()


func on():
	$CPUParticles2D.emitting = true
	$Spike/CollisionShape2D.disabled = false


func off():
	$CPUParticles2D.emitting = false
	$Spike/CollisionShape2D.disabled = true
