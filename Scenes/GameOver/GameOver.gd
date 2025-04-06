extends Node2D

var game_scene = preload("res://Scenes/TestScene/TestScene.tscn")
var happy_face = load("res://graphics/main_character/mc_happy_face.png")
var angry_face = load("res://graphics/main_character/mc_angry_face.png")

func _ready() -> void:
	$CanvasLayer/Control/ScoreLabel.text = "Score: " + str(GameManager.getScore())
	if GameManager.win:
		$PlayerCharacter/sprites/body/head/face.texture = happy_face
	else:	
		$PlayerCharacter/sprites/body/head/face.texture = angry_face

func _on_restart_button_button_down() -> void:
	GameManager.resetScore()
	get_tree().change_scene_to_file("res://Scenes/TestScene/TestScene.tscn")
