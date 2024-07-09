extends CharacterBody2D


var fall = false
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	
	if fall == true:
		velocity.y += gravity * delta

	move_and_slide()


func _on_area_2d_body_entered(body):
	if body.name == "Player":
		fall = true
