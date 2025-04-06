extends Control

var _time_left: int
const SCORE_SCALING := 2

func _ready() -> void:
	_time_left = GameManager.GAME_LENGTH
	$GameCountdown.start(GameManager.GAME_LENGTH)
	
func _process(delta: float) -> void:
	var new_time = int(floor($GameCountdown.time_left))
	if new_time != _time_left:
		GameManager.changeScore((_time_left - new_time)*SCORE_SCALING)
		_time_left = new_time
		$TimerText.text = _convert_to_minutes_text(_time_left)

func _convert_to_minutes_text(time: int) -> String:
	var minutes = floor(time/60)
	var seconds = time - (minutes*60)
	return str(minutes) + ":" + str(seconds)

func _on_game_countdown_timeout() -> void:
	GameManager.endGame()
