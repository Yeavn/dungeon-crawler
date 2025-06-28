extends CharacterBody2D

@export var speed = 150
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

var direction = "down"
var is_locked := false

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	if !is_locked:
		velocity = input_direction * speed
		if Input.is_action_just_pressed("attack"):
			animated_sprite.stop()
			animated_sprite.play("attack_" + direction)
			is_locked = true
			velocity = Vector2.ZERO
		elif Input.is_action_pressed("left"):
			animated_sprite.play("run_left")
			direction = "left"
		elif Input.is_action_pressed("right"):
			animated_sprite.play("run_right")
			direction = "right"
		elif Input.is_action_pressed("down"):
			animated_sprite.play("run_down")
			direction = "down"
		elif Input.is_action_pressed("up"):
			animated_sprite.play("run_up")
			direction = "up"
		else:
			animated_sprite.play("idle_down")

func _physics_process(delta):
	
	if !animated_sprite.is_playing():
		is_locked = false
	
	get_input()
	move_and_slide()
