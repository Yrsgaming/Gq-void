extends Node2D
@onready var inputs_tutorials: Sprite2D = $InputsTutorials
@onready var input_players: Sprite2D = $InputPlayers
@onready var animation_player: AnimationPlayer = $AnimationPlayer

@export var player = 1
func _ready() -> void:
	inputs_tutorials.frame = player - 1
	input_players.frame = player - 1
	animation_player.play("up_down")
