extends Sprite2D

var bounce_amount = 10
var up = true
var initial_position
var target_position

# Called when the node enters the scene tree for the first time.
func _ready():
	initial_position = global_position
	target_position = initial_position.y - bounce_amount

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if global_position.y > target_position and up:
		global_position.y += delta * -5
	elif global_position.y <= target_position and up:
		global_position.y = target_position
		target_position = initial_position.y
		up = false
		
	if global_position.y < target_position and !up:
		global_position.y += delta * 5
	elif global_position.y >= target_position and !up:
		global_position.y = target_position
		target_position = initial_position.y - bounce_amount
		up = true


func _on_area_2d_body_entered(body):
	if body.name == "Player":
		body.grapple_unlocked = true
		get_tree().call_group("grapple_powerup", "queue_free")
		print(body.grapple_unlocked)
	pass # Replace with function body.
