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

var state := MonsterState.MOVING

func _ready() -> void:
	contact_monitor = true
	max_contacts_reported = 1
	
func take_damage(damage: int):
	health -= damage
	if health <= 0:
		call_deferred("queue_free")

func _physics_process(delta: float) -> void:
	if state == MonsterState.MOVING:
		move_and_collide(get_velocity(delta))

func get_velocity(delta: float):
	return Vector2(SPEED * speed_modifier * delta, 0)
