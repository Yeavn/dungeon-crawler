extends Area2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var area_2d: Area2D = $"."
@onready var sprite_2d: Sprite2D = $Sprite2D


var textures : Array[Texture2D] = []
var new_item
var player = null

func set_item(item: InvItem):
	sprite_2d.texture = item.texture
	new_item = item
	animation_player.play("drop")

#func _ready() -> void:
	#for i in range(19):
		#textures.append(load("res://assets/items/Item_%02d.png" % i))
		#i += 1
	#var item = randi_range(0, 18)
	#var texture : Texture2D = textures[item]
	#print("Item ", item , " gedroppt!")
	#sprite_2d.texture = texture
	#animation_player.play("drop")
	
func _on_body_entered(body: Node2D) -> void:
	if body.name == "player":
		queue_free()
		body.collect(new_item)
		body.add_effects(new_item.effects)
