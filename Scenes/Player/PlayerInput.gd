extends CharacterBody2D

@export var move_speed: int = 400
@export var jump_height: int = 100
@export var jump_time_to_peak: float = 0.5
@export var jump_time_to_descent: float = 0.4
@export var animator: PlayerAnimator

@onready var jump_velocity: float = (2 * jump_height) / jump_time_to_peak * -1
@onready var jump_gravity: float = (-2 * jump_height) / (jump_time_to_peak * jump_time_to_peak) * -1
@onready var fall_gravity: float = (-2 * jump_height) / (jump_time_to_descent* jump_time_to_descent) * -1

var bullet_scene: PackedScene = preload("res://Scenes/Bullet/GravityBullet.tscn")

@export var extra_jump_count: int = 1 # How many extra jumps the player is allowed after jumping from a surface (1 is double jump)

var jump_count: int = 0
var can_hug := false
var hugging := false

func _ready() -> void:
	GameManager.changeAmmo(1)

func _input(event: InputEvent) -> void:
	if hugging:
		if event.is_action_released("Hug") and hugging:
			stop_hugging()
		return # disallow anything else while hugging
		
	if event.is_action_pressed("Jump") and (is_on_floor() or can_extra_jump()):
		jump()

	if event.is_action_pressed("Shoot"):
		shoot()

	if (event.is_action_pressed("Down")):
		set_collision_mask_value(6, false)
	if (event.is_action_released("Down")):
		set_collision_mask_value(6, true)
		
	if event.is_action_pressed("Hug") and can_hug:
		start_hugging()
		

func can_extra_jump() -> bool:
	return !is_on_floor() and jump_count <= extra_jump_count


func _physics_process(delta):
	if hugging:
		return
		
	velocity.y += _get_gravity() * delta
	set_move_velocity()

	move_and_slide()

	if jump_count > 0 and is_on_floor_only():
		jump_count = 0
		animator.land()


func _get_gravity() -> float:
	return jump_gravity if velocity.y <= 0 else fall_gravity


func jump():
	velocity.y = jump_velocity
	jump_count += 1
	animator.jump()


func shoot():
	if GameManager.getAmmo() > 0:
		var bullet: Node = bullet_scene.instantiate()
		bullet.DIRECTION = get_viewport().get_mouse_position() - position
		bullet.START_POSITION = position
		get_parent().add_child(bullet)
		GameManager.changeAmmo(-1)


func set_move_velocity():
	if is_on_floor() == false:
		pass

	var direction: float = Input.get_axis("Left", "Right")
	velocity.x = direction * move_speed

	animator.set_movement(velocity, is_on_floor())

func start_hugging():
	global_position = Vector2(249, 720)
	velocity = Vector2.ZERO
	hugging = true
	GameManager.player_start_hug.emit()
	animator.hug()
	
func stop_hugging():
	hugging = false
	GameManager.player_stop_hug.emit()
	animator.stop_hug()

func _on_hug_area_area_entered(area: Area2D) -> void:
	can_hug = true

func _on_hug_area_area_exited(area: Area2D) -> void:
	can_hug = false
