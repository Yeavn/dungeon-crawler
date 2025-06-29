extends CharacterBody2D

@onready var agent: NavigationAgent2D = $NavigationAgent2D
@onready var healthbar: ProgressBar = $ProgressBar


var player

@export var speed := 100.0
@export var health := 100.0
@export var player_distance := 50
@export var start_pathfinding_distance := 100

func _ready() -> void:
	add_to_group("enemies")
	player = get_node("/root/Main/player")
		
func _physics_process(delta: float) -> void:
	var player_pos = player.global_position
	var distance_to_player = global_position.distance_to(player_pos)
	
	if distance_to_player <= start_pathfinding_distance and distance_to_player > player_distance:
		agent.target_position = player_pos
		
		var current_agent_pos = global_position
		var next_path_position = agent.get_next_path_position()
		var new_velocity = current_agent_pos.direction_to(next_path_position) * speed
		
		if agent.avoidance_enabled:
			agent.set_velocity_forced(new_velocity)
		else:
			_on_navigation_agent_2d_velocity_computed(new_velocity)
		move_and_slide()
	else:
		_on_navigation_agent_2d_velocity_computed(Vector2.ZERO)
		
func _on_navigation_agent_2d_velocity_computed(safe_velocity: Vector2) -> void:
	velocity = safe_velocity

func take_damage(amount: int) -> void:
	health -= amount
	print("Genger nimmt ", amount, " Schaden!")
	print("Genger hat ", health, " Leben!")
	healthbar.value = health
	if health <= 0:
		queue_free()
