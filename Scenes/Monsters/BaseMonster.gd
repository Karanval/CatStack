extends RigidBody2D

class_name BaseMonster

const SPEED := -200 # go left
const HEALTH := 100
const DISTANCE_SQRD_TO_TARGET_GOAL := 100000

enum MonsterState {
	MOVING,
	DISTURBING
}

@export var target := Vector2(174, 734)
@export var damage := 10
@export var health := HEALTH
@export var speed_modifier := 1

var damage_tween: Tween
var state := MonsterState.MOVING

func _ready() -> void:
	contact_monitor = true
	max_contacts_reported = 1
	
func take_damage(damage: int):
	health -= damage
	if damage_tween:
		damage_tween.kill()
	
	if health <= 0:
		damage_tween = create_tween()
		damage_tween.tween_property($Sprite2D, "modulate", Color.TRANSPARENT, 0.1)
		damage_tween.tween_callback(queue_free)
	else:
		damage_tween = create_tween()
		damage_tween.tween_property($Sprite2D, "modulate", Color.PURPLE, 0.1)
		damage_tween.tween_property($Sprite2D, "modulate", modulate, 0.1)

func cause_disturbance():
	state = MonsterState.DISTURBING
	freeze = true
	set_collision_layer_value(3, false)
	
	if damage_tween:
		damage_tween.kill()
	damage_tween = create_tween()
	damage_tween.tween_property($Sprite2D, "modulate", Color.DARK_RED, 0.3)
	damage_tween.tween_property($Sprite2D, "modulate", Color.TRANSPARENT, 0.6)
	damage_tween.parallel().tween_property($Sprite2D, "scale", Vector2.ZERO, 0.5).set_ease(Tween.EASE_IN)
	damage_tween.parallel().tween_property($Sprite2D, "rotation", 600, 0.5).set_ease(Tween.EASE_IN)
	damage_tween.parallel().tween_property(self, "global_position", target, 0.6)
	damage_tween.tween_callback(queue_free)

func _physics_process(delta: float) -> void:
	if state == MonsterState.MOVING:
		move_and_collide(get_velocity(delta))

func get_velocity(delta: float):
	return Vector2(SPEED * speed_modifier * delta, 0)
