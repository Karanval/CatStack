extends Node

enum Effect{Knock, Shoot, Chicken, Monke, Step, Maraca}

@export var effects : Dictionary[Effect, AudioStream]


func play_effect(type: Effect) -> void:
	var sfx = effects[type]
	
	var player: AudioStreamPlayer = AudioStreamPlayer.new()
	add_child(player)
	player.bus = "Effects"
	player.stream = sfx
	player.finished.connect(player.queue_free) 
	player.play()
