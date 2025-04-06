extends Node2D

@export var CUDDLE_PER_SECOND: int

const _CUDDLE_UPDATES_PER_SECOND: float = 10

var _sleep: int
var _cuddle: bool

signal sleep_changed

func _ready() -> void:
	_cuddle = false
	GameManager.changeSleep(_sleep)
	$CuddleTime.start(1.0/_CUDDLE_UPDATES_PER_SECOND)
	$CuddleTime.paused = true
	
func _change_sleep(amount: int) -> void:		
	GameManager.changeSleep(amount)
		
func _on_area_2d_body_entered(body: Node2D) -> void:
	# Monster reaches the child
	if body.is_in_group("monsters"):
		var monster = body as BaseMonster
		_change_sleep(-monster.damage)
		monster.call_deferred("cause_disturbance")
	# Player cuddles with the child
	else:
		$CuddleTime.paused = false

func _on_area_2d_body_exited(body: Node2D) -> void:
	if !(body.is_in_group("monsters")):
		$CuddleTime.paused = true

func _on_cuddle_time_timeout() -> void:
	_change_sleep(int(CUDDLE_PER_SECOND/_CUDDLE_UPDATES_PER_SECOND))

### DEBUG FEATURE
func _input(event: InputEvent) -> void:
	if event.is_action("ui_up"):
		_change_sleep(1)
	if event.is_action("ui_down"):
		_change_sleep(-1)
