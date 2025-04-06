extends BaseMonster

var movementTime := 0.0

var direction: Vector2

@export var sin_magnitude_min := 1
@export var sin_magnitude_max := 3
@export var sin_frequency_min := 5
@export var sin_frequency_max := 8

var sin_magnitude
var sin_frequency
#var recalculate_direction_cooldown = 2

func _ready() -> void:
	randomize()
	sin_magnitude = randf_range(sin_magnitude_min, sin_magnitude_max)
	sin_frequency = randf_range(sin_frequency_min, sin_frequency_max)
	
func _enter_tree() -> void:
	direction = (global_position - target).normalized()
	print(direction)
	
func get_velocity(delta: float):
	movementTime += delta
	var ghostly_float = sin(sin_frequency * movementTime) * sin_magnitude
	return Vector2(SPEED * direction.x * speed_modifier * delta, SPEED * (ghostly_float + direction.y) * speed_modifier * delta)
	
