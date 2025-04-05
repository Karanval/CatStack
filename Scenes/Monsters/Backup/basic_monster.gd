extends BaseMonster

@export var jump_chance := 0.333
@export var jump_cooldown_min := 1.0
@export var jump_cooldown_max := 3.0
@export var jump_pulse_min := 500
@export var jump_pulse_max := 1000

var jump_cooldown := 2.0

func _ready():
	reset_cooldown()
	
func get_velocity(delta: float):
	if jump_cooldown > 0:
		jump_cooldown -= delta
	else:
		reset_cooldown()
		if randf() < jump_chance:
			apply_impulse(Vector2(0, -randi_range(jump_pulse_min, jump_pulse_max)))
	return super(delta)

func reset_cooldown():
	jump_cooldown = randf_range(jump_cooldown_min, jump_cooldown_max)
