extends Control

@export var MAX_SLEEP = 100
var _sleep
signal wake_up
signal sleep_changed

func _ready() -> void:
	_sleep = MAX_SLEEP
	$SleepValue.text = str(_sleep)
	
func change_sleep(amount: int) -> void:
	_sleep += amount
	if _sleep > MAX_SLEEP:
		_sleep = MAX_SLEEP
	if _sleep <= 0:
		_sleep = 0
		emit_signal("wake_up")
		
	$SleepValue.text = str(_sleep)
	_updateProgressBar()
	emit_signal("sleep_changed",_sleep)
	
func _input(event: InputEvent) -> void:
	if event.is_action("ui_up"):
		change_sleep(1)
	if event.is_action("ui_down"):
		change_sleep(-1)

func _updateProgressBar() -> void:
	$ProgressBar.value = _sleep
