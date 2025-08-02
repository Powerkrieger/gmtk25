extends CharacterBody2D

const SPEED: int = 140
var input_dir: Vector2 = Vector2.ZERO
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var playback: AnimationNodeStateMachinePlayback = animation_tree.get("parameters/StateMachine/playback")
@onready var sword: Node2D = $Sword


func _physics_process(delta):
	var state = playback.get_current_node()
	match state:
		"MoveState": move_state(delta)
		#"AttackState": pass

func move_state(_delta) -> void:
	input_dir = Input.get_vector("left","right","up","down")
	if input_dir:
		velocity = input_dir * SPEED
		animation_tree.set("parameters/StateMachine/MoveState/WalkState/blend_position", input_dir)
		animation_tree.set("parameters/StateMachine/MoveState/IdleState/blend_position", input_dir)
	else: 
		velocity = Vector2.ZERO
	move_and_slide()
	if Input.is_action_just_pressed("attack"):
		sword.attack()
