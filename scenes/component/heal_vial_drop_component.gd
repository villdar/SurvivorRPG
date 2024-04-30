extends Node

@export_range(0,1) var drop_percent: float = .1
@export var health_component: Node
@export var heal_vial_scene: PackedScene 

func _ready():
	(health_component as HealthComponent).died.connect(on_died)

func on_died():
	if randf() > drop_percent:
		return
	
	if heal_vial_scene == null: 
		return
	
	if not owner is Node2D:
		return
	
	var spawn_position = (owner as Node2D).global_position
	var heal_vial_instance = heal_vial_scene.instantiate() as Node2D 
	var entities_layer = get_tree().get_first_node_in_group("entities_layer")
	if entities_layer == null:
		return
	entities_layer.add_child(heal_vial_instance) 
	heal_vial_instance.global_position = spawn_position
	
