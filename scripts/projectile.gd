extends Area2D

@onready var projectileScene = preload("res://projectile.tscn")

@onready var collisionShape = $CollisionShape2D
@onready var sprite = $Sprite2D


var velocity: Vector2 = Vector2.ZERO
var size = 5


# Initialize projectile
func init_projectile(speed: float, dir: int, _size: int) -> void:
	add_to_group("bubble")
	
	self.body_entered.connect(_on_entered_body)
	velocity = Vector2(0, speed * dir)
	size += _size
	
	collisionShape.shape.radius = size
	sprite.scale = Vector2(size / 10, size / 10)

# Spawning	


# Movement + Out-of-bounds handling
func _physics_process(delta: float) -> void:
	position += velocity * delta
	if position.y < -100:
		queue_free()

# Collision handling
func _on_entered_body(body: Node) -> void:
	if body.is_in_group("player"):
		queue_free()
		# Decrease player HP
	elif body.is_in_group("enemy"):
		queue_free()
		# Decrease boss HP
	elif body.is_in_group("bubble"):
		queue_free()

# Merging bubbles
func merge_with_bubble(body: Node) -> void:
	var combinedSize = self.size + body.size
	var combinedSpeed = self.velocity.y + body.velocity.y
	var mergedProjectile = projectileScene.instantiate()

	# Ensure merged projectile is added to parent
	get_parent().add_child(mergedProjectile)
	mergedProjectile.position = (self.position + body.position) / 2
	mergedProjectile.init_projectile(combinedSpeed, 1, combinedSize)

	# Remove current and other bubbles
	queue_free()
	body.queue_free()
