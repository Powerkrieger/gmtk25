extends CharacterBody2D

const SPEED: int = 100
var input_dir: Vector2 = Vector2.ZERO
@onready var animation_tree: AnimationTree = $AnimationTree


func _ready():
	pass
	
func _physics_process(delta):
	player_movement(delta)

func player_movement(_delta):
	input_dir = Input.get_vector("left","right","up","down")
	if input_dir:
		velocity = input_dir * SPEED
		animation_tree.set("parameters/StateMachine/MoveState/WalkState/blend_position", input_dir)
		animation_tree.set("parameters/StateMachine/MoveState/IdleState/blend_position", input_dir)
	else: 
		velocity = Vector2.ZERO
	
	move_and_slide()
