extends Control

var tween: Tween
var going_green := false

func _ready() -> void:
	GameManager.sleep_changed.connect(updateSleepValue)
	GameManager.score_changed.connect(updateScoreValue)
	$ScoreValue.text = str(0)

func updateSleepValue(sleep: int) -> void:
	if (sleep > $MarginContainer/ProgressBar.value):
		if !going_green:
			going_green = true
			if (tween):
				tween.kill()
			tween = create_tween()
			tween.tween_property($MarginContainer/ProgressBar, "modulate", Color("#00ff81"), 0.5)
			tween.tween_property($MarginContainer/ProgressBar, "modulate", Color("#ffffff"), 0.5)
			tween.tween_callback(reset_green)
	else:
		going_green = false
		$MarginContainer/ProgressBar.modulate = Color("#ff00b9")
		if (tween):
			tween.kill()
		tween = create_tween()
		tween.tween_property($MarginContainer/ProgressBar, "modulate", Color("#ffffff"), 0.2)
		
	$MarginContainer/ProgressBar.value = sleep

func reset_green():
	going_green = false
	
func updateScoreValue(score: int) -> void:
	$ScoreValue.text = str(score)
	
	
	# ff00b9 red
	# 00ff81 green
