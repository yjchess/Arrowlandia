extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	await get_tree().create_timer(10).timeout
	get_tree().change_scene_to_file("res://scenes/levels/test_stage.tscn")
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
