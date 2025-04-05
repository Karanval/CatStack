extends Node2D

@export var MAX_SLEEP: int
@export var CUDDLE_PER_SECOND: int

const _CUDDLE_UPDATES_PER_SECOND: float = 10

var _sleep: int
var _cuddle: bool

signal sleep_changed

func _ready() -> void:
	_cuddle = false
	_sleep = MAX_SLEEP
	GameManager.changeSleep(_sleep)
	$CuddleTime.start(1.0/_CUDDLE_UPDATES_PER_SECOND)
	$CuddleTime.paused = true
	
func _change_sleep(amount: int) -> void:
	_sleep += amount
	if _sleep > MAX_SLEEP:
		_sleep = MAX_SLEEP
	if _sleep <= 0:
		_sleep = 0
		emit_signal("wake_up")
		
	emit_signal("sleep_changed",_sleep)
	GameManager.changeSleep(_sleep)
		
# Player cuddles with the child
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("monsters"):
		var monster = body as BaseMonster
		_change_sleep(-monster.damage)
	else:
		$CuddleTime.paused = false

func _on_area_2d_body_exited(body: Node2D) -> void:
	if !(body.is_in_group("monsters")):
		$CuddleTime.paused = true

func _on_cuddle_time_timeout() -> void:
	_change_sleep(CUDDLE_PER_SECOND/_CUDDLE_UPDATES_PER_SECOND)

### DEBUG FEATURE
func _input(event: InputEvent) -> void:
	if event.is_action("ui_up"):
		_change_sleep(1)
	if event.is_action("ui_down"):
		_change_sleep(-1)
