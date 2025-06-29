extends Area2D

@export var item_scene: PackedScene
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var timer: Timer = $Timer

@export var number_of_items: int
@export var items: Array[InvItem]
@onready var collision_shape: CollisionShape2D = $Area2D/CollisionShape2D

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
	for i in range(number_of_items):
		var item = randi_range(0, items.size() - 1)
		var item_scene = item_scene.instantiate()
		var offset = Vector2(
			randf_range(-shape.extents.x, shape.extents.x),
			randf_range(-shape.extents.y, shape.extents.y)
		)
		item_scene.global_position = global_position + offset
		get_tree().current_scene.add_child(item_scene)
		item_scene.set_item(items[item])

func _on_timer_timeout() -> void:
	drop_items()
	#var item_instance = item_scene.instantiate()
	#item_instance.global_position = self.global_position + Vector2(5, -5)
	#get_tree().current_scene.add_child(item_instance)
	timer.stop()
	
