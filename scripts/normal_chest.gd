extends Area2D

@export var item_scene: PackedScene
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var timer: Timer = $Timer

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
			


func _on_timer_timeout() -> void:
	var item_instance = item_scene.instantiate()
	item_instance.global_position = self.global_position
	get_tree().current_scene.add_child(item_instance)
	timer.stop()
	
