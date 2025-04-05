extends CharacterBody2D

@export var move_speed: int = 400
@export var jump_height: int = 100
@export var jump_time_to_peak: float = 0.5
@export var jump_time_to_descent: float = 0.4

@onready var jump_velocity: float = (2 * jump_height) / jump_time_to_peak * -1
@onready var jump_gravity: float = (-2 * jump_height) / (jump_time_to_peak * jump_time_to_peak) * -1
@onready var fall_gravity: float = (-2 * jump_height) / (jump_time_to_descent* jump_time_to_descent) * -1

var bullet_scene: PackedScene = preload("res://Scenes/Bullet/Bullet.tscn")


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Jump"):
		jump()
	if event.is_action_pressed("Shoot"):
		shoot()

	set_collision_mask_value(6, !event.is_action_pressed("Down"))


func _physics_process(delta):
	velocity.y += _get_gravity() * delta
	set_move_velocity()

	move_and_slide()


func _get_gravity() -> float:
	return jump_gravity if velocity.y <= 0 else fall_gravity


func jump():
	velocity.y = jump_velocity


func shoot():
	var bullet: Node = bullet_scene.instantiate()
	bullet.DIRECTION = get_viewport().get_mouse_position() - position
	bullet.START_POSITION = position
	get_parent().add_child(bullet)


func set_move_velocity():
	if is_on_floor() == false:
		pass

	var direction: float = Input.get_axis("Left", "Right")
	velocity.x = direction * move_speed
