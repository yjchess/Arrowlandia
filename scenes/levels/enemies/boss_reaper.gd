extends CharacterBody2D

@export var Player:CharacterBody2D
var speed = 50
var spawned = false
var phase = 1

func _ready():
	$AnimatedSprite2D.play("spawn")
	await get_tree().create_timer(3.4).timeout
	$AnimatedSprite2D.play("idle_2")
	spawned = true

func _physics_process(delta):
	if spawned == true && phase == 1:
		global_position = global_position.move_toward(Player.global_position, speed*delta)
	
	
	
func _process(delta):
	if Player.global_position.x < global_position.x:$AnimatedSprite2D.flip_h = true
	else:$AnimatedSprite2D.flip_h = false


func _on_area_2d_body_entered(body):
	if body.name =="Player":
		print("Hi world")
		$AttackArea/CollisionShape2D.disabled = false
		$AnimatedSprite2D.play("attack")
		await get_tree().create_timer(2.4).timeout
		$AttackArea/CollisionShape2D.disabled = true
		$Area2D/CollisionShape2D.disabled = true
		$Area2D/CollisionShape2D.disabled = false
		$AnimatedSprite2D.play("idle_2")

func _on_attack_area_body_entered(body):
	if body.name =="Player":
		print("Player Hit!")
