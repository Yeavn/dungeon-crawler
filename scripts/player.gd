extends CharacterBody2D

@export var speed = 150
@export var damage = 50
@export var attack_range = 50

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var ray_cast: RayCast2D = $RayCast2D

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
			
			# Check attack
			if ray_cast.is_colliding():
				var colider = ray_cast.get_collider()
				if colider.is_in_group("enemies"):
					if global_position.distance_to(colider.global_position) <= attack_range:
						colider.take_damage(damage)
		elif Input.is_action_pressed("left"):
			animated_sprite.play("run_left")
			direction = "left"
			ray_cast.target_position = Vector2(-32, 0)
		elif Input.is_action_pressed("right"):
			animated_sprite.play("run_right")
			direction = "right"
			ray_cast.target_position = Vector2(32, 0)
		elif Input.is_action_pressed("down"):
			animated_sprite.play("run_down")
			direction = "down"
			ray_cast.target_position = Vector2(0, 32)
		elif Input.is_action_pressed("up"):
			animated_sprite.play("run_up")
			direction = "up"
			ray_cast.target_position = Vector2(0, -32)
		else:
			animated_sprite.play("idle_down")
			ray_cast.target_position = Vector2(0, 32)
			

func add_damage(amount: int):
	damage += amount

func _physics_process(delta):
	
	if !animated_sprite.is_playing():
		is_locked = false
	
	get_input()
	move_and_slide()
