extends CharacterBody2D

const CRATE_EFFECT = preload("res://scenes/crate_effect.tscn")
const SPEED: int = 125
var direction: Vector2 = Vector2.ZERO
var chase: bool = false
var player: CharacterBody2D = null
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var nav: NavigationAgent2D = $NavigationAgent2D


func _physics_process(_delta: float) -> void:
	if chase:
		nav.target_position = player.global_position
		var current_agent_position: Vector2 = global_position
		var next_path_position: Vector2 = nav.get_next_path_position()
		direction = current_agent_position.direction_to(next_path_position)
		animation_tree.set("parameters/StateMachine/MoveState/WalkState/blend_position", direction)
		animation_tree.set("parameters/StateMachine/MoveState/IdleState/blend_position", direction)
	else:
		direction = Vector2.ZERO
	velocity = direction * SPEED
	move_and_slide()

func _on_chase_area_body_entered(body: Node2D) -> void:
	player = body
	chase = true

func _on_chase_area_body_exited(_body: Node2D) -> void:
	chase = false
	player = null

func create_grass_effect() -> void:
	var crate_effect = CRATE_EFFECT.instantiate()
	get_tree().root.add_child(crate_effect)
	crate_effect.global_position = global_position
	queue_free()

func _on_hurtbox_area_entered(_area: Area2D) -> void:
	create_grass_effect()
