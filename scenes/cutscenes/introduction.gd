extends Control
var clicks = -1
var reveal_speed := 0.05 # Speed at which the text reveals itself
var current_text_length := 0
var incrementable = true
var startable_animation = true
var speeds = [0.0015, 0.003, 0.0045, 0.0015, 0.003]
@onready var labels = [$Panel/Panel/RichTextLabel, $Panel/Panel/RichTextLabel2, $Panel/Panel/RichTextLabel3, $Panel/Panel/RichTextLabel4, $Panel/Panel/RichTextLabel5 ]
@onready var animations = [[$Panel/Panel/RichTextLabel/AnimatedSprite2D],[$Panel/Panel/RichTextLabel2/AnimatedSprite2D,$Panel/Panel/RichTextLabel2/AnimatedSprite2D2],[$Panel/Panel/RichTextLabel3/AnimatedSprite2D],[$Panel/Panel/RichTextLabel4/AnimatedSprite2D], []]
@onready var label_animation_one = $Panel/Panel/RichTextLabel/AnimatedSprite2D
@onready var label_animation_timer_one = $"Panel/Panel/RichTextLabel/AnimatedSprite2D/Visible Timer"



# Called when the node enters the scene tree for the first time.
func _ready():
	for label in labels:
		label.visible = false
		label.visible_ratio = 0
	


func _process(delta):
	if Input.is_action_just_pressed("shoot") and incrementable == true:
		clicks += 1
	
	if clicks >= 0 and clicks <5:
		if clicks == 0:
			if startable_animation:
				label_animation_timer_one.start()
				startable_animation = false
		incrementable = false
		labels[clicks].visible = true
		# Adjusted to ensure smooth visibility increase regardless of delta time
		if labels[clicks].visible_ratio < 1:
			labels[clicks].visible_ratio += min(speeds[clicks], 1 - labels[clicks].visible_ratio)
		else:
			incrementable = true
			if clicks != 0:
				var animation_set = animations[clicks]
				for animation in animation_set:
					if animation.visible != true:
						animation.play("default")
					animation.visible = true
		
	if clicks == 5:
		await get_tree().create_timer(2).timeout
		get_tree().change_scene_to_file("res://scenes/levels/test_stage.tscn")
		
	


func _on_visible_timer_timeout():
	label_animation_one.visible = true
	pass # Replace with function body.
