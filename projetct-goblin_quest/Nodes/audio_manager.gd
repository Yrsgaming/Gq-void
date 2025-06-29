extends Node


@onready var musica_greengoblin: AudioStreamPlayer = $musica_greengoblin

func change_music(music_int):
	match music_int:
		0:
			musica_greengoblin.play()
