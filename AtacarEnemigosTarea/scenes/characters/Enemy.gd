extends KinematicBody2D

export(int) var w_range = 50

var speed = 800
var accel = 50
var velocity = Vector2.ZERO
onready var state_machine = $AnimationTree.get("parameters/playback")

onready var start_position = global_position
onready var target_position = global_position

onready var timer = $Timer
var attack = false
var attack_left = false
var attack_right = false
var hit = false
var health = 100
var dead = false
var move_towards_player = false
var player_direction = Vector2.ZERO
onready var hurtbox = $Hurtbox.get_node("CollisionShape2D")
onready var hitbox = $Hitbox.get_node("CollisionShape2D")
onready var collision_shape = $CollisionShape2D

func update_target_position():
	var target_vector = Vector2(rand_range(-w_range, w_range), rand_range(-w_range, w_range))
	print(target_vector)
	target_position = start_position + target_vector
	state_machine.travel("walk")

func _physics_process(delta):
	
	var direction = global_position.direction_to(target_position)
	velocity = velocity.move_toward(direction*speed, accel*delta)
	
	if global_position.distance_to(target_position) < 0.1:
		state_machine.travel("idle")
		velocity = Vector2.ZERO
	if attack:
		if attack_left:
			$Sprite.scale.x = -1
			attack_left = false
		elif attack_right:
			$Sprite.scale.x = 1	
			attack_right = false
		state_machine.travel('attack')
		attack = false	
	if hit:
		state_machine.travel('hit')	
		hit = false
	if dead:
		state_machine.travel('dead')
		velocity = Vector2.ZERO
		hitbox.disabled = true
		hurtbox.disabled = true
		collision_shape.disabled = true
	if move_towards_player:
		print(direction.x)
		velocity = velocity.move_toward(global_position.direction_to(player_direction)*speed, accel*delta)
		
	if velocity.x < 0:
		$Sprite.scale.x = -1
	else:
		$Sprite.scale.x = 1	
			
				
	move_and_slide(velocity)

func _on_Timer_timeout():
	update_target_position()
	var duration = rand_range(10, 16)
	timer.start(duration)



func _on_Hitbox_area_entered(area):
	if area.get_owner().velocity.x >= 0:
		attack_left = true
	else:
		attack_right = true
	attack = true	
	
		
	


func _on_Hurtbox_area_entered(area):
	hit = true
	health -=50
	if health <=0:
		dead = true
	


func _on_Locationbox_area_entered(area):
	print(area.get_owner().position)
	player_direction = area.get_owner().position
	move_towards_player = true
	
