extends CharacterBody2D

# Preload the projectile scene
@onready var projectile_scene = preload("res://projectile.tscn")
@onready var enemy_scene = preload("res://enemy.tscn")

var speed = 300  
var viewport
func _ready():
	add_to_group("player")
	spawn_enemy()
	

func _process(delta):
	if Input.is_action_just_pressed("shoot"): 
		spawn_projectile()

func spawn_projectile():
	var projectile = projectile_scene.instantiate()
	get_parent().add_child(projectile)
	projectile.position = position + Vector2(0, -100)
	projectile.init_projectile(300, -1, 10)

func spawn_enemy():
	var nextEnemy = enemy_scene.instantiate()
	get_parent().add_child(nextEnemy)
	nextEnemy.position = position + Vector2(0, -100)
	nextEnemy.init_enemy(300, 100, 10, 2, 1, 0)
	print(get_parent().get_children())

func _physics_process(delta):
	# Handle player movement
	position.x = clamp(position.x, Global.viewport[0]*0.1, Global.viewport[0]*0.9)
	var input_direction = 0
	if Input.is_action_pressed("move_left"):
		input_direction -= 1
	if Input.is_action_pressed("move_right"):
		input_direction += 1

	velocity.x = input_direction * speed
	position.y = Global.viewport[1] * 0.8
	 
	# Apply velocity to the character
	move_and_slide()
	
	if Global.hp <= 0:
		queue_free()
