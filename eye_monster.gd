extends CharacterBody2D


const SPEED = 300.0


func _physics_process(delta):


	velocity.x = -SPEED*delta


	move_and_slide()
