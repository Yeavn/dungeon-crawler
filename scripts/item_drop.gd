extends Area2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var area_2d: Area2D = $"."


func _ready() -> void:
	animation_player.play("drop")
	
