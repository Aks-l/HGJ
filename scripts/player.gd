extends CharacterBody2D

# Preload the projectile scene
@onready var projectile_scene = preload("res://projectile.tscn")


var speed = 300  
var viewport
func _ready():
	add_to_group("player")

func _process(delta):
	if Input.is_action_just_pressed("shoot"): 
		spawn_projectile()

func spawn_projectile():
	var projectile = projectile_scene.instantiate()
	get_parent().add_child(projectile)
	projectile.position = position + Vector2(0, -100)
	projectile.init_projectile(300, -1, 10)

func _physics_process(delta):
	# Handle player movement
	var input_direction = 0
	if Input.is_action_pressed("move_left"):
		input_direction -= 1
	if Input.is_action_pressed("move_right"):
		input_direction += 1

	velocity.x = input_direction * speed
	position.y = Global.viewport[1] * 0.8
	 
	# Apply velocity to the character
	move_and_slide()
