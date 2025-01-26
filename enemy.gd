extends CharacterBody2D  # Use a movable body type

@onready var projectile_scene = preload("res://projectile.tscn")
@onready var enemy_scene = preload("res://enemy.tscn")

@onready var collisionShape = $CollisionShape2D
@onready var sprite = $Sprite2D
@onready var texture = preload("res://sprites/character.png")

var rng = RandomNumberGenerator.new()

# Variables

var speed = 200
var bulletSize = 10
var bulletSpeed = 300
var reload = 10
var moving = false
var target_x = null
var bossID = 0

func init_enemy(_speed: float, _hp: float, _bulletSize: int, _reload: int, _bulletSpeed: int, _bossID: int) -> void:
	Global.mehp = _hp
	Global.ehp = Global.mehp
	speed = _speed
	bulletSize = _bulletSize
	bulletSpeed = _bulletSpeed
	bossID = _bossID
	texture = preload("res://sprites/boss.png")
	var spriteNode = get_node("Sprite2D")
	spriteNode.texture = texture
	print("inited")

func _ready():
	print("no")
	add_to_group("enemy")

func spawn_projectile():
	var projectile = projectile_scene.instantiate()
	get_parent().add_child(projectile)
	projectile.position = position + Vector2(0, 100)
	projectile.init_projectile(bulletSpeed+rng.randi_range(-50,50), 1, bulletSize)

func _physics_process(delta):
	print("hm")
	print(position)
	position.y = Global.viewport[1] * 0.2
	if not moving:
		# Set a random target position and direction
		target_x = rng.randi_range(100, 1000)
		velocity.x = speed * sign(target_x - position.x) # Determine movement direction
		moving = true
	else:
		# Apply movement
		velocity.x = speed * sign(target_x - position.x)
		move_and_slide()
		# Stop movement
		if abs(position.x - target_x) < 5:
			spawn_projectile()
			moving = false
			velocity = Vector2.ZERO  # Stop movement
	
	if Global.ehp <= 0:
		print("noo")
		queue_free()
		var nextEnemy = enemy_scene.instantiate()
		get_parent().add_child(nextEnemy)
		nextEnemy.position = position
		nextEnemy.init_enemy(speed*1.1, Global.mehp*1.5, bulletSize+2, reload+2, bulletSpeed*1.2, bossID+1)
	
		
		
