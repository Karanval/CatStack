extends Node2D

var game_scene = preload("res://Scenes/TestScene/TestScene.tscn")

func _ready() -> void:
	$CanvasLayer/Control/ScoreLabel.text = "Score: " + str(GameManager.getScore())

func _on_restart_button_button_down() -> void:
	GameManager.resetScore()
	get_tree().change_scene_to_file("res://Scenes/TestScene/TestScene.tscn")
