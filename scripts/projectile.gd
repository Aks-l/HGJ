# Projectile.gd
extends Area2D

var velocity
var direction

func _ready():
	direction = -1 if position.y > 350 else 1
	velocity = Vector2(0, 300*direction)

func _physics_process(delta):
	# Move the projectile based on velocity
	position += velocity * delta

	# Optional: Destroy the projectile if it goes off-screen
	if position.y < -100:  # Adjust based on your game's viewport
		queue_free()
		
func init_projectile(_speed: float):
	velocity = Vector2(0, _speed)
