extends CharacterBody2D

# Preload the projectile scene
@onready var projectile_scene = preload("res://projectile.tscn")

# Player movement speed (adjusted to a reasonable value)
var speed = 300  

func _ready():
	spawn_projectile()
	spawn_projectile()  # Optional: Test spawning on ready

func _process(delta):
	if Input.is_action_just_pressed("shoot"): 
		print("Shoot action detected")
		spawn_projectile()

func spawn_projectile():
	var projectile = projectile_scene.instantiate()
	get_parent().add_child(projectile)
	projectile.position = position + Vector2(0, -20)
	projectile.init_projectile(-300)

func _physics_process(delta):
	# Handle player movement
	var input_direction = 0
	if Input.is_action_pressed("move_left"):
		print_debug("Moving left")
		input_direction -= 1
	if Input.is_action_pressed("move_right"):
		print_debug("Moving right")
		input_direction += 1

	velocity.x = input_direction * speed
	
	# Apply velocity to the character
	move_and_slide()
