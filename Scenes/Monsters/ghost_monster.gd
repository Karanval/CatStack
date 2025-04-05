extends BaseMonster

var movementTime := 0.0

var direction: Vector2

func _ready() -> void:
	direction = (global_position - target).normalized()
	
func get_velocity(delta: float):
	movementTime += delta
	#return Vector2(SPEED * speed_modifier * delta, )
	return Vector2(SPEED * direction.x * speed_modifier * delta, SPEED * direction.y * speed_modifier * delta)
