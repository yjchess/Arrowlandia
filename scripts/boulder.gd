extends CharacterBody2D



func _physics_process(delta):
	if velocity != Vector2.ZERO:
		rotation_degrees += 5
	
	if not is_on_floor():
		velocity.y += 10
	else:
		velocity.y = 0
	
	move_and_slide()

func trigger():
	velocity.x = 100
	
