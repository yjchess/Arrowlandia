extends CharacterBody2D

@export var Player:CharacterBody2D
var speed = 50
var spawned = false
var phase = 1
var health = 10
var direction
var direction_x = 1
var direction_y = -1

func _ready():
	$AnimatedSprite2D.play("spawn")
	await get_tree().create_timer(3.4).timeout
	$AnimatedSprite2D.play("idle_2")
	spawned = true

func _physics_process(delta):
	if spawned == true && phase == 1:

		direction = global_position.move_toward(Player.global_position, speed)
		velocity = (direction - global_position) * (speed * delta)
	

	move_and_slide()
	
	
	
func _process(delta):
	if Player.global_position.x < global_position.x:
		$AnimatedSprite2D.flip_h = true
		$AttackArea.scale.x=-1
	else:
		$AnimatedSprite2D.flip_h = false
		$AttackArea.scale.x=1
	
	if health <= 0:
		$"../Ground/Ground Layer3".queue_free()
		$"../Ground/Grappable Layer".queue_free()
		queue_free()


func _on_area_2d_body_entered(body):
	if body.name =="Player":
		#print("Hi world")
		call_deferred("disable_attack_area")
		$AnimatedSprite2D.play("attack")
		await get_tree().create_timer(2.4).timeout
		call_deferred("enable_attack_area")
		call_deferred("disable_detection_area")
		call_deferred("enable_detection_area")
		$AnimatedSprite2D.play("idle_2")

func disable_attack_area():    $AttackArea/CollisionShape2D.set_deferred("disabled", true)
func enable_attack_area():     $AttackArea/CollisionShape2D.set_deferred("disabled", false)
func disable_detection_area(): $Area2D/CollisionShape2D.set_deferred("disabled", true)
func enable_detection_area():  $Area2D/CollisionShape2D.set_deferred("disabled", false)

func _on_attack_area_body_entered(body):
	if body.name =="Player":
		print("Player Hit!")

func _on_arrow_collision():
	health -=1
	print(health)
