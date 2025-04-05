extends Node2D

var game_scene = preload("res://Scenes/TestScene/TestScene.tscn")

func _on_restart_button_button_down() -> void:
	var root = get_tree().root
	var level = root.get_node("GameOver")
	root.remove_child(level)
	level.call_deferred("free")

	# Add the next level
	var next_level = game_scene.instantiate()
	root.add_child(next_level)
