extends CharacterBody2D
var health = 3
const SPEED = 600.0
const JUMP_VELOCITY = -400.0
var invulnerable = false
var moving = true
var bodies_inside = []
var attacking = false
var death = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var final_location = $Final_Location.global_position
@export var direction = "right"
signal PlayerHit
		

func _physics_process(delta):
	if not is_on_floor():
		velocity.y = gravity * delta
		
	if !invulnerable:
		if direction =="right" and final_location.x > global_position.x:
			scale.x = 1
			if moving == true:
				velocity.x = SPEED*delta
				
		elif direction == "right" and final_location.x < global_position.x:
			global_position.x = final_location.x
			scale.x = -1
			direction = "left"
			final_location = $Final_Location.global_position
		
		if direction =="left" and final_location.x < global_position.x:
			if moving == true:
				velocity.x = -SPEED*delta
		elif direction == "left" and final_location.x > global_position.x:
			global_position.x = final_location.x
			direction = "right"
			final_location = $Final_Location.global_position
	else:
		velocity = Vector2.ZERO
	if moving == false:
		velocity = Vector2.ZERO
	
	if invulnerable == false:
		$AnimatedSprite2D.play("walk")
	move_and_slide()
	
	
func _on_arrow_collision():
	if invulnerable == false:
		$InvulnerableTimer.start()
		$AnimatedSprite2D.play("hurt")
		print(health)
		health -=1
		if health == 0:
			invulnerable = true
			#await the time it takes for the hurt animation to play before death
			#await get_tree().create_timer(1.4).timeout
			
			#await the time it takes for the death animation + 1 second to despawn
			$AnimatedSprite2D.play("death")
			$CollisionShape2D.disabled = true
			death = true
			moving = false
			await get_tree().create_timer(3.8).timeout
			queue_free()
	
		invulnerable = true
	


func _on_invulnerable_timer_timeout():
	if death == false:
		invulnerable = false


func _on_area_2d_body_entered(body):
	
	bodies_inside.append(body.name)
	if body.name == "Player" and attacking == false and death == false:
		var old_velocity = velocity
		attacking = true
		$DetectPlayerTimer.start()
		moving = false
		$Attack_Animation.show()
		$Attack_Animation.play("attack")
		$AnimatedSprite2D.hide()
		velocity = Vector2.ZERO
		await get_tree().create_timer(1.5).timeout
		attacking = false
		moving = true
		velocity = old_velocity
		$Attack_Animation.stop()
		$Attack_Animation.hide()
		$AnimatedSprite2D.show()
		$Area2D/CollisionShape2D.disabled = true
		$Area2D/CollisionShape2D.disabled = false
		
func _on_detect_player_timer_timeout():
	if bodies_inside.has("Player") == true:
		print("Player inside")
		emit_signal("PlayerHit")
	

func _on_area_2d_body_exited(body):
	bodies_inside.erase(body.name)
