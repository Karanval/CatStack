extends Node2D

@export var CUDDLE_PER_SECOND: int

const _CUDDLE_UPDATES_PER_SECOND: float = 10

var _sleep: int
var _cuddle: bool

signal sleep_changed

func _ready() -> void:
	_cuddle = false
	GameManager.changeSleep(_sleep)
	GameManager.player_start_hug.connect(_on_player_start_hug)
	GameManager.player_stop_hug.connect(_on_player_stop_hug)
	$CuddleTime.start(1.0/_CUDDLE_UPDATES_PER_SECOND)
	$CuddleTime.paused = true
	
func _change_sleep(amount: int) -> void:		
	GameManager.changeSleep(amount)
		
# Player cuddles with the child
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("monsters"):
		var monster = body as BaseMonster
		_change_sleep(-monster.damage)
		monster.call_deferred("cause_disturbance")

func _on_cuddle_time_timeout() -> void:
	_change_sleep(int(CUDDLE_PER_SECOND/_CUDDLE_UPDATES_PER_SECOND))

func _on_player_start_hug() -> void:
	$CuddleTime.paused = false

func _on_player_stop_hug() -> void:
	$CuddleTime.paused = true
	
### DEBUG FEATURE
func _input(event: InputEvent) -> void:
	if event.is_action("ui_up"):
		_change_sleep(1)
	if event.is_action("ui_down"):
		_change_sleep(-1)
