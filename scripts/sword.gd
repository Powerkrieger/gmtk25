extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

var is_attacking: bool = false

func _physics_process(_delta):
	var mouse_pos = get_global_mouse_position()
	look_at(mouse_pos)

func attack():
	if !is_attacking:
		animation_player.play("slash")
		is_attacking = true

func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	is_attacking = false
