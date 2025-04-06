extends Node

@export var MAX_SLEEP := 100
@export var MAX_AMMO := 15
@export var GAME_LENGTH := 120

var _ammo: int
var _sleep: int
var _score:= 0

var game_over_scene = preload("res://Scenes/GameOver/GameOver.tscn")
signal sleep_changed
signal player_start_hug
signal player_stop_hug
signal ammo_changed
signal score_changed

func _init():
	_sleep = MAX_SLEEP
	_ammo = MAX_AMMO
	setAmmo(_ammo)
	#Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)

func _notification(what: int) -> void:
	if what == NOTIFICATION_APPLICATION_FOCUS_IN:
		Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Esc"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		
func changeSleep(change: int):
	_sleep += change
	if change < 0:
		changeScore(change)
	if _sleep > MAX_SLEEP:
		_sleep = MAX_SLEEP
	if _sleep <= 0:
		_sleep = 0
		print("GAME OVER")
		_switch_to_game_over_screen()
	emit_signal("sleep_changed", _sleep)

func changeAmmo(change: int):
	_ammo += change
	if _ammo > MAX_AMMO:
		_ammo = MAX_AMMO
	if _ammo <= 0:
		_ammo = 0
	setAmmo(_ammo)
	
func setAmmo(ammoValue: int):
	_ammo = ammoValue
	emit_signal("ammo_changed", _ammo)

func getAmmo() -> int:
	return _ammo
	
func changeScore(change: int):
	_score += change
	emit_signal("score_changed", _score)
	
func resetScore():
	_score = 0
	emit_signal("score_changed", _score)
	
func getScore() -> int:
	return _score
	
func endGame():
	_switch_to_game_over_screen()
	
func _switch_to_game_over_screen():
	_init()
	get_tree().change_scene_to_file("res://Scenes/GameOver/GameOver.tscn")
