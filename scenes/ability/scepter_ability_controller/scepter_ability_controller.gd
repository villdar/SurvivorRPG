extends Node

@export var scepter_ability_scene: PackedScene
@export var scepter_projectile_scene: PackedScene

var base_damage = 2
const MAX_RANGE = 150
var base_wait_time

func _ready():
	base_wait_time = $Timer.wait_time
	$Timer.timeout.connect(on_timer_timeout)


func on_timer_timeout():
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if player == null:
		return
	var enemies = get_tree().get_nodes_in_group("enemy")
	enemies = enemies.filter(func(enemy: Node2D):
		return enemy.global_position.distance_squared_to(player.global_position) < pow(MAX_RANGE, 2)
	)
	if enemies.size() == 0:
		return
		
	enemies.sort_custom(func(a: Node2D, b: Node2D):
		var a_distance = a.global_position.distance_squared_to(player.global_position)
		var b_distance = b.global_position.distance_squared_to(player.global_position)
		return a_distance < b_distance
	)
	
	var closest_enemy = enemies[0]
	
	var foreground = get_tree().get_first_node_in_group("foreground_layer") as Node2D
	if foreground == null:
		return
	
	var scepter_ability_instance = scepter_ability_scene.instantiate() as Node2D
	foreground.add_child(scepter_ability_instance)
	scepter_ability_instance.global_position = player.global_position
	
	var enemy_direction = enemies[0].global_position - scepter_ability_instance.global_position
	scepter_ability_instance.rotation = enemy_direction.angle()
	
	var projectile = scepter_projectile_scene.instantiate() as Node2D
	foreground.add_child(projectile)
	projectile.global_position = player.global_position
	
	var direction = (closest_enemy.global_position - player.global_position).normalized()
	projectile.velocity = direction * 500
	projectile.hitbox_component.damage = base_damage

