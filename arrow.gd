extends CharacterBody2D


const SPEED = 800.0
const JUMP_VELOCITY = -400.0
const initial_arc = -100

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	velocity.y = initial_arc

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity/2 * delta
		velocity.x = SPEED
		if rotation_degrees <75:
			rotation_degrees += 1
	else:
		velocity.x = 0
		velocity.y = 0

	move_and_slide()


func _on_despawn_timer_timeout():
	queue_free()
	pass # Replace with function body.

func isGrounded():
	return is_on_floor()
