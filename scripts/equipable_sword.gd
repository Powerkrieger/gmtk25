extends Node2D

const SWORD = preload("res://scenes/sword.tscn")
const CRATE_EFFECT = preload("res://scenes/crate_effect.tscn")

@onready var interaction_area: InteractionArea = $InteractionArea
@onready var player: CharacterBody2D = get_tree().get_first_node_in_group("Player")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	interaction_area.interact = Callable(self, "_on_pick_up")


func _on_pick_up() -> void:
	var sword = SWORD.instantiate()
	player.add_child(sword)
	create_grass_effect()


func create_grass_effect() -> void:
	var crate_effect = CRATE_EFFECT.instantiate()
	get_tree().root.add_child(crate_effect)
	crate_effect.global_position = global_position
	queue_free()
