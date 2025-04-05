extends Node

@export var MAX_SLEEP := 100

var _sleep: int

var game_over_scene = preload("res://Scenes/GameOver/GameOver.tscn")
signal sleep_changed
signal ammo_changed
signal game_over


func _init():
	_sleep = MAX_SLEEP
	#Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)

func _notification(what: int) -> void:
	if what == NOTIFICATION_APPLICATION_FOCUS_IN:
		Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Esc"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		
func changeSleep(change: int):
	_sleep += change
	if _sleep > MAX_SLEEP:
		_sleep = MAX_SLEEP
	if _sleep <= 0:
		_sleep = 0
		print("GAME OVER")
		_switch_to_game_over_screen()
	emit_signal("sleep_changed", _sleep)

func changeAmmo(ammoValue: int):
	emit_signal("ammo_changed", ammoValue)
	
func _switch_to_game_over_screen():
	#get_node("/root/TestScene").free()
	var root  = get_tree().root
	var level = root.get_node("TestScene")
	root.remove_child(level)
	level.call_deferred("free")

	# Add the next level
	var next_level = game_over_scene.instantiate()
	root.add_child(next_level)
