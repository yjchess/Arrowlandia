extends CharacterBody2D

@export var arrow:PackedScene
const SPEED = 70.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		$AnimatedSprite2D.play("jump")
	
	if Input.is_action_just_pressed("shoot"):
		$AnimatedSprite2D.play("shoot")
		var arrow_scene = arrow.instantiate()
		$Node2D.look_at(get_global_mouse_position())
		arrow_scene.position = $Node2D/ArrowPoint.global_position
		get_tree().root.add_child(arrow_scene)
		arrow_scene.velocity = (get_global_mouse_position() - arrow_scene.global_position)*2
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
		if $AnimatedSprite2D.is_playing():
			if $AnimatedSprite2D.animation != "jump" and $AnimatedSprite2D.animation != "shoot": $AnimatedSprite2D.play("run")
		else:$AnimatedSprite2D.play("run")
		#if not Input.is_action_just_pressed("jump") or Input.is_action_just_pressed("shoot"): $AnimatedSprite2D.play("run")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if $AnimatedSprite2D.is_playing():
			if $AnimatedSprite2D.animation != "jump" and $AnimatedSprite2D.animation != "shoot": $AnimatedSprite2D.play("idle")
		else:$AnimatedSprite2D.play("idle")
			
		#if not Input.is_action_just_pressed("jump") or Input.is_action_just_pressed("shoot"): $AnimatedSprite2D.play("idle")
	move_and_slide()
	
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		if collision.get_collider().is_in_group("enemy"):
			print(collision.get_collider().name)

func _process(delta):
	if Input.is_action_pressed("left"):
		scale.x = -1
		print(scale.x)
	if Input.is_action_pressed("right"):
		scale.x = 1
