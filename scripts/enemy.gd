extends CharacterBody2D  # Use a movable body type

@onready var projectile_scene = preload("res://projectile.tscn")

var rng = RandomNumberGenerator.new()

# Variables
var speed = 200
var moving = false
var target_x = null

func _ready():
	add_to_group("enemy")

func spawn_projectile():
	var projectile = projectile_scene.instantiate()
	get_parent().add_child(projectile)
	projectile.position = position + Vector2(0, 100)
	projectile.init_projectile(300+rng.randi_range(-50,50), 1, 10)

func _physics_process(delta):
	position.y = Global.viewport[1] * 0.2
	
	if not moving:
		# Set a random target position and direction
		spawn_projectile()
		target_x = rng.randi_range(100, 1000)
		velocity.x = speed * sign(target_x - position.x)  # Determine movement direction
		moving = true
	else:
		# Apply movement
		velocity.x = speed * sign(target_x - position.x)
		move_and_slide()

		# Check if the target is reached
		if abs(position.x - target_x) < 5:
			moving = false
			velocity = Vector2.ZERO  # Stop movement
