extends CharacterBody2D

@export var up: bool
var fall := false
var move := false
var before_movement_position : Vector2
var destination_y : float
var initial_position : Vector2

# Assuming gravity is defined elsewhere or fetched from project settings
var gravity : float = 9.8 # Example value, adjust according to your needs

func _ready():
	initial_position = global_position
	before_movement_position = initial_position

func _physics_process(delta):
	global_position.x = initial_position.x
	velocity.x = 0
	if fall:
		velocity.y += gravity
		
	if is_on_floor():
		fall = false
	
	if move:
		$Area2D/CollisionShape2D.disabled = true
		set_collision_layer_value(1,false)
		set_collision_mask_value(1, false)
		if destination_y < before_movement_position.y:
			velocity.y = -gravity
		else:
			velocity.y = gravity
	elif not fall:
		velocity.y = 0
			
	if !move:
		set_collision_layer_value(1,true)
		set_collision_mask_value(1, true)
		
	if destination_y < before_movement_position.y and destination_y >= global_position.y:
		#print("Move False 1")
		move = false
		up = false
		$Area2D/CollisionShape2D.disabled = false
	elif destination_y > before_movement_position.y and destination_y <= global_position.y:
		#print("Move False 2")
		move = false
		up = true
		$Area2D/CollisionShape2D.disabled = false
		
	move_and_slide()


func _on_area_2d_body_entered(body):
	if body.name == "Player":
		fall = true

func _on_target_arrow_collision():
	print("Arrow Collision")
	move = !move # Toggle move state
	destination_y = initial_position.y - (96 if up else 0) # Adjust destination_y based on up flag
	print(destination_y)
	before_movement_position = global_position
