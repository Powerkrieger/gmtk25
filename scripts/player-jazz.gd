extends CharacterBody2D

const CRATE_EFFECT = preload("res://scenes/crate_effect.tscn")
const SPEED: int = 140
const MAX_HEALTH: int = 5
var input_dir: Vector2 = Vector2.ZERO
var damage_cooldown: bool = false
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var playback: AnimationNodeStateMachinePlayback = animation_tree.get("parameters/StateMachine/playback")
@onready var health_bar: HealthBar = $HealthBar
@onready var regenerate_life: Timer = $RegenerateLife
@onready var damage_cooldown_timer: Timer = $DamageCooldown
@onready var hurtbox: Area2D = $Hurtbox

var health: float = MAX_HEALTH : set = _set_health

func _ready() -> void:
	health_bar.init_healt(health)
	health_bar.hide()

func _physics_process(delta):
	if !damage_cooldown:
		check_overlapping_bodies()
	var state = playback.get_current_node()
	match state:
		"MoveState": move_state(delta)

func check_overlapping_bodies():
	var overlapping_bodies = hurtbox.get_overlapping_bodies()
	for body in overlapping_bodies:
		if body.is_in_group("Enemy"):
			health -= body.damage
			damage_cooldown = true
			damage_cooldown_timer.start()

func move_state(_delta) -> void:
	input_dir = Input.get_vector("left","right","up","down")
	if input_dir:
		velocity = input_dir * SPEED
		animation_tree.set("parameters/StateMachine/MoveState/WalkState/blend_position", input_dir)
		animation_tree.set("parameters/StateMachine/MoveState/IdleState/blend_position", input_dir)
	else: 
		velocity = Vector2.ZERO
	move_and_slide()

func create_grass_effect() -> void:
	var crate_effect = CRATE_EFFECT.instantiate()
	get_tree().root.add_child(crate_effect)
	crate_effect.global_position = global_position
	propagate_call("hide")
	propagate_call("set_physics_process", [false])

func _set_health(new_value):
	health = min(new_value, MAX_HEALTH)
	health_bar.health = health
	if health <= 0:
		create_grass_effect()
	if health >= MAX_HEALTH:
		health_bar.hide()
	else:
		health_bar.show()

func _on_regenerate_life_timeout() -> void:
	health += 1


func _on_damage_cooldown_timeout() -> void:
	damage_cooldown = false
