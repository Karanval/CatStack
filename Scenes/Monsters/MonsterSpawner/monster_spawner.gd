extends Node2D

const TOTAL_MONSTERS := 3

@export var timer_minimum := 1.0
@export var timer_maximum := 5.0
@export var ground_spawn_locations: Array[Vector2]
@export var air_spawn_locations: Array[Vector2]
@export var basicMonster: PackedScene
@export var toddyMonster: PackedScene
@export var ghostMonster: PackedScene
@export var ghostBoss: PackedScene

@onready var current_timer_minimum := timer_maximum
var game_time := 0.0

func _ready() -> void:
	randomize()
	reset_timer()
	
func _process(delta: float) -> void:
	game_time += delta
	current_timer_minimum = lerpf(timer_maximum, timer_minimum, game_time / GameManager.GAME_LENGTH )
	
func _on_timer_timeout() -> void:
	if (GameManager.GAME_LENGTH - game_time <= 25):
		var instance = ghostBoss.instantiate()
		var spawn_location = air_spawn_locations[randi() % air_spawn_locations.size()]
		instance.global_position = spawn_location
		add_child(instance)
		$Timer.stop()
		return
		
	var monster = randi() % TOTAL_MONSTERS
	var instance: BaseMonster
	var spawn_location: Vector2
	match monster:
		0: 
			instance = basicMonster.instantiate()
			spawn_location = ground_spawn_locations[randi() % ground_spawn_locations.size()]
		1:
			instance = toddyMonster.instantiate()
			spawn_location = ground_spawn_locations[randi() % ground_spawn_locations.size()]
		2: 
			instance = ghostMonster.instantiate()
			spawn_location = air_spawn_locations[randi() % air_spawn_locations.size()]
	
	instance.global_position = spawn_location
	add_child(instance)
	reset_timer()
	
func reset_timer():
	$Timer.wait_time = randi_range(current_timer_minimum, timer_maximum)
	$Timer.start()
