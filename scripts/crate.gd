extends StaticBody2D

const CRATE_EFFECT = preload("res://scenes/crate_effect.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func create_grass_effect() -> void:
	var crate_effect = CRATE_EFFECT.instantiate()
	get_tree().root.add_child(crate_effect)
	crate_effect.global_position = global_position
	queue_free()


func _on_hurtbox_area_entered(_area: Area2D) -> void:
	create_grass_effect()
