extends CharacterBody2D

# Variable
var speed = 200  # Adjust speed as needed

func _physics_process(delta):
	# Reset horizontal velocity
	velocity.x = 0

	# Check for input
	if Input.is_action_pressed("move_left"):
		velocity.x -= speed
	elif Input.is_action_pressed("move_right"):
		velocity.x += speed

	# Apply velocity to the character
	move_and_slide()
