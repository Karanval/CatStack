extends Node

signal sleep_changed
	
func changeSleep(sleepValue: int):
	emit_signal("sleep_changed", sleepValue)
