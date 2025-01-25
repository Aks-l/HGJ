extends Area2D

@onready var projectileScene = preload("res://projectile.tscn")
@onready var collisionShape = $CollisionShape2D
@onready var sprite = $Sprite2D

var velocity: Vector2 = Vector2.ZERO
var size: float
var isMerging = false

# Initialize projectile
func init_projectile(speed: float, dir: int, newsize: float) -> void:
	velocity = Vector2(0, speed * dir)
	size = newsize
	collisionShape.shape.radius = size * 1.41
	var radius = collisionShape.shape.radius
	var texture_size = sprite.texture.get_size()
	sprite.scale = Vector2(radius * 2 / texture_size.x, radius * 2 / texture_size.y)
	add_to_group("bubble")


func _ready() -> void:
	self.body_entered.connect(_on_entered_body)
	self.area_entered.connect(_on_area_entered)
	add_to_group("bubble")

# Movement + Out-of-bounds handling
func _physics_process(delta: float) -> void:
	position += velocity * delta
	if position.y < -100:
		queue_free()

# Collision handling
func _on_entered_body(body: Node) -> void:
	print_debug(self)
	if body.is_in_group("player"):
		Global.hp -= 1
		queue_free()
		# Decrease player HP
	elif body.is_in_group("enemy"):
		Global.ehp -= 1
		queue_free()

func _on_area_entered(area: Area2D) -> void:
	#avoid both collision detections causing a double merge going infinite
	if isMerging or area.isMerging:
		return
	if area.is_in_group("bubble"):
		isMerging = true
		area.isMerging = true
		queue_free()
		merge_with_bubble(area)
		

# Merging bubbles
func merge_with_bubble(body: Node) -> void:
	var combinedSize = sqrt((self.size**2 + body.size**2))
	var combinedSpeed = self.velocity.y + body.velocity.y
	var mergedProjectile = projectileScene.instantiate()
	# Ensure merged projectile is added to parent
	get_parent().add_child(mergedProjectile)
	mergedProjectile.position = (self.position + body.position) / 2
	mergedProjectile.init_projectile(combinedSpeed, 1, combinedSize)

	# Remove current and other bubbles
	queue_free()
	body.queue_free()
