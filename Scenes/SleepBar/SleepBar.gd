extends Control

func _ready() -> void:
	GameManager.sleep_changed.connect(updateSleepValue)
	GameManager.score_changed.connect(updateScoreValue)
	$ScoreValue.text = str(0)

func updateSleepValue(sleep: int) -> void:
	$MarginContainer/ProgressBar.value = sleep
	
func updateScoreValue(score: int) -> void:
	$ScoreValue.text = str(score)
