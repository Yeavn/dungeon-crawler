extends Area2D

@export var item_scene: PackedScene
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var timer: Timer = $Timer

@export var number_of_items: int = randf_range(1, 5)
@export var collision_shape: CollisionShape2D

var opened = false

func _on_body_entered(body):
	if body.name == "player" && opened == false:
		open_chest()

func open_chest():
	opened = true
	print("Truhe geöffnet!")
	if item_scene:
		animated_sprite.play("default")
		timer.start()
			
func drop_items():
	var shape = collision_shape.shape as RectangleShape2D
	var _spawn_area_size = shape.extents * 2
	for i in number_of_items:
		var item = item_scene.instantiate()
		var offset = Vector2(
			randf_range(-shape.extents.x, shape.extents.x),
			randf_range(-shape.extents.y, shape.extents.y)
		)
		
		item.global_position = global_position + offset
		get_tree().current_scene.call_deferred("add_child", item)

func _on_timer_timeout() -> void:
	drop_items()
	#var item_instance = item_scene.instantiate()
	#item_instance.global_position = self.global_position + Vector2(5, -5)
	#get_tree().current_scene.add_child(item_instance)
	timer.stop()
	
