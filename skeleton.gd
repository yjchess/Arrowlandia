extends CharacterBody2D


const SPEED = 400.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var final_location = $Final_Location.global_position
@onready var direction = "right"
		
	

func _physics_process(delta):
	if not is_on_floor():
		velocity.y = gravity * delta
	
	if direction =="right" and final_location.x > global_position.x:
		rotation_degrees=0
		velocity.x = SPEED*delta
	elif direction == "right" and final_location.x < global_position.x:
		rotation_degrees = 180
		$AnimatedSprite2D.flip_h = true
		direction = "left"
		final_location = $Final_Location.global_position
	
	if direction =="left" and final_location.x < global_position.x:
		rotation_degrees = 0
		velocity.x = -SPEED*delta
	elif direction == "left" and final_location.x > global_position.x:
		rotation_degrees = 0
		$AnimatedSprite2D.flip_h = false
		direction = "right"
		final_location = $Final_Location.global_position
		
	var collision = move_and_collide(velocity * delta)
	if collision:
		if collision.get_collider().is_in_group("arrow"):
			print("With arrow!")
			var arrow = collision.get_collider()
			if arrow.isGrounded() == false:
				$AnimatedSprite2D.play("hurt")

					
			arrow.queue_free()
	move_and_slide()
