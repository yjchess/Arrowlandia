extends Sprite2D
@export_enum("One","Five","Ten") var value = 0
var textures:Array = ["res://assets/Coins/Coins/Coins/Original Diminsions/Small/Copper 1 Piece.png", 
"res://assets/Coins/Coins/Coins/Original Diminsions/Small/Silver 5 Piece.png", 
"res://assets/Coins/Coins/Coins/Original Diminsions/Small/Gold 10 Piece.png"]

func _ready():
	var image_path = textures[value]
	var image_texture = load(image_path)
	self.texture = image_texture


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if skew < 90:
		skew += 2 * delta
	else:
		skew = -89.9
	pass
