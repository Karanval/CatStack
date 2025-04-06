extends Control

var _time_left: int

func _ready() -> void:
	_time_left = GameManager.GAME_LENGTH
	$GameCountdown.start(GameManager.GAME_LENGTH)
	
func _process(delta: float) -> void:
	var new_time = int(floor($GameCountdown.time_left))
	if new_time != _time_left:
		GameManager.changeScore(_time_left - new_time)
		_time_left = new_time
		$TimerText.text = str(_time_left)


func _on_game_countdown_timeout() -> void:
	GameManager.endGame()
