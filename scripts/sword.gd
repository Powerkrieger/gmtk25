extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

var is_attacking: bool = false
var damage: int = 1

func _physics_process(_delta):
	if Input.is_action_just_pressed("attack"):
		attack()
	else:
		var mouse_pos = get_global_mouse_position()
		look_at(mouse_pos)

func attack():
	if !is_attacking:
		animation_player.play("slash")
		is_attacking = true

func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	is_attacking = false
