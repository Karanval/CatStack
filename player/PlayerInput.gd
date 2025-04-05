extends CharacterBody2D

@export var move_speed: int = 400
@export var jump_height: int = 100
@export var jump_time_to_peak: float = 0.5
@export var jump_time_to_descent: float = 0.4

@onready var jump_velocity: float = (2 * jump_height) / jump_time_to_peak * -1
@onready var jump_gravity: float = (-2 * jump_height) / (jump_time_to_peak * jump_time_to_peak) * -1
@onready var fall_gravity: float = (-2 * jump_height) / (jump_time_to_descent* jump_time_to_descent) * -1


func _physics_process(delta):
	velocity.y += _get_gravity() * delta
	set_move_velocity()

	if Input.is_action_just_pressed("Jump"):
		jump()

	move_and_slide()

func _get_gravity() -> float:
	return jump_gravity if velocity.y <= 0 else fall_gravity


func jump():
	velocity.y = jump_velocity


func set_move_velocity():
	if is_on_floor() == false:
		pass

	var direction: float = Input.get_axis("Left", "Right")
	velocity.x = direction * move_speed
