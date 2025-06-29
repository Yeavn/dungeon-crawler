extends Area2D

@export var enemy_scene : PackedScene
@export var number_of_enemies: int = 5
@export var collision_shape: CollisionShape2D
# @onready var collision_shape: CollisionShape2D = $CollisionShape2D

func _ready():
	spawn_enemies()
	
func spawn_enemies():
	var shape = collision_shape.shape as RectangleShape2D
	var _spawn_area_size = shape.extents
	for i in number_of_enemies:
		var enemy = enemy_scene.instantiate()
		
		var offset = Vector2(
			randf_range(-shape.extents.x, shape.extents.x),
			randf_range(-shape.extents.y, shape.extents.y)
		)
		enemy.global_position = global_position + offset
		
		get_tree().current_scene.call_deferred("add_child", enemy)
