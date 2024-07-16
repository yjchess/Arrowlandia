extends CharacterBody2D


const SPEED = 50.0


func _physics_process(delta):
	velocity.x = -SPEED
	move_and_slide()

func _on_arrow_collision():
	pass
