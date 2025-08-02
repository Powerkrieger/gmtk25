extends Node2D

@export var player: CharacterBody2D
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var hitbox: Area2D = $Sprite2D/Hitbox
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var is_attacking: bool = false

func _physics_process(_delta):
	var mouse_pos = get_global_mouse_position()
	look_at(mouse_pos)

func attack():
	if !is_attacking:
		animation_player.play("slash")
		is_attacking = true

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	is_attacking = false
