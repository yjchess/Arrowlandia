extends CharacterBody2D

var health = 3
const SPEED = 600.0
const JUMP_VELOCITY = -400.0
var invulnerable = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var final_location = $Final_Location.global_position
@onready var direction = "right"
		
	

func _physics_process(delta):
	if not is_on_floor():
		velocity.y = gravity * delta
	
	if direction =="right" and final_location.x > global_position.x:
		scale.x = 1
		velocity.x = SPEED*delta
	elif direction == "right" and final_location.x < global_position.x:
		global_position.x = final_location.x
		scale.x = -1
		direction = "left"
		final_location = $Final_Location.global_position
	
	if direction =="left" and final_location.x < global_position.x:
		velocity.x = -SPEED*delta
	elif direction == "left" and final_location.x > global_position.x:
		global_position.x = final_location.x
		direction = "right"
		final_location = $Final_Location.global_position
		
	#var collision = move_and_collide(velocity * delta)
	#if collision:
	#	if collision.get_collider().is_in_group("arrow"):
	#		print("With arrow!")
	#		var arrow = collision.get_collider()
	#		if arrow.isGrounded() == false:
	#			$AnimatedSprite2D.play("hurt")

					
	#		arrow.queue_free()
	#move_and_slide()
	
	#var collision = move_and_collide(velocity * delta)
	#if collision:
	#	var collider = collision.get_collider()
	#	print(collider.get_name())
	#	# Check if the collider is an arrow and if it's moving towards the skeleton
	#	if collider.is_in_group("arrow") and (direction == "right" and collider.velocity.x >= 0 or direction == "left" and collider.velocity.x <= 0):
	#		print("With arrow!")
	#		
	#		# Assuming the arrow has a method to check if it's grounded
	#		if not collider.isGrounded():
	#			$AnimatedSprite2D.play("hurt")
	#		
	#		collider.queue_free()

	move_and_slide()
	
	
func _on_arrow_collision():
	if invulnerable == false:
		$InvulnerableTimer.start()
		$AnimatedSprite2D.play("hurt")
		print(health)
		health -=1
		if health == 0:
			#await the time it takes for the hurt animation to play before death
			await get_tree().create_timer(1.4).timeout
			queue_free()
	
		invulnerable = true
	


func _on_invulnerable_timer_timeout():
	invulnerable = false
	pass # Replace with function body.


func _on_area_2d_body_entered(body):
	print("Area entered")
	$Attack_Animation.show()
	$Attack_Animation.play("attack")
	$AnimatedSprite2D.hide()
	var old_velocity = velocity
	velocity = Vector2(0,0)
	await get_tree().create_timer(3).timeout
	velocity = old_velocity
	$Attack_Animation.stop()
	$Attack_Animation.hide()
	$AnimatedSprite2D.show()
	print(body)
