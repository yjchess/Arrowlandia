extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_flag_level_complete():
	get_tree().change_scene_to_file("res://scenes/levels/level_two.tscn")
	pass # Replace with function body.
