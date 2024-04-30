extends Node2D

@onready var hitbox_component = $HitboxComponent

var velocity = Vector2()

func _process(delta):
	global_position += velocity * delta

