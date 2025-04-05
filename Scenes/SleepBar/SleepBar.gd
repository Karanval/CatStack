extends Control

func _ready() -> void:
	GameManager.sleep_changed.connect(updateSleepValue)

func updateSleepValue(sleep: int) -> void:
	$ProgressBar.value = sleep
	$SleepValue.text = str(sleep)
	
