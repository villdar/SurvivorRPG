extends Node

@export var knockback_strength = 50
@export var is_knockable = false

func apply_knockback(velocity_component: Node):
	var knockback_upgrade = MetaProgression.get_upgrade_count("add_knockback")
	if knockback_upgrade <= 0:
		return
	var knockback_direction = (get_parent().global_position * -1).normalized()
	var knockback_magnitude = knockback_strength * (knockback_upgrade + .5)
	if is_knockable == true:
		velocity_component.velocity += knockback_direction * knockback_magnitude
	else:
		return
