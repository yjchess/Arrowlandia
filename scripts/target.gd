extends StaticBody2D
@export var attachment:Node2D
signal shot

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_arrow_collision():
	emit_signal("shot")
	attachment._on_target_arrow_collision()
