extends Node2D

const TOTAL_MONSTERS := 2

@export var timer_minimum := 1.0
@export var timer_maximum := 3.0
@export var ground_spawn_locations: Array[Vector2]
@export var air_spawn_locations: Array[Vector2]
@export var basicMonster: PackedScene
@export var ghostMonster: PackedScene

func _ready() -> void:
	randomize()
	reset_timer()
	
func _on_timer_timeout() -> void:
	var monster = randi() % TOTAL_MONSTERS
	var instance: BaseMonster
	var spawn_location: Vector2
	match monster:
		0: 
			instance = basicMonster.instantiate()
			spawn_location = ground_spawn_locations[randi() % ground_spawn_locations.size()]
		1: 
			instance = ghostMonster.instantiate()
			spawn_location = air_spawn_locations[randi() % air_spawn_locations.size()]
	
	instance.global_position = spawn_location
	add_child(instance)
	reset_timer()
	
func reset_timer():
	$Timer.wait_time = randi_range(timer_minimum, timer_maximum)
	$Timer.start()
