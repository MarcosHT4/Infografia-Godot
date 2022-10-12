extends KinematicBody2D

const ACCEL = 1200
const MAX_SPEED = 600
const FRICTION = 1200

var hurt = false
var dead = false
var health = 100
var block = false

var velocity = Vector2.ZERO
onready var state_machine = $AnimationTree.get("parameters/playback")

func _physics_process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCEL * delta)
		state_machine.travel("run")
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		state_machine.travel("idle")
		
	if Input.is_action_just_pressed("attack"):
		state_machine.travel("attack1")
	if Input.is_action_just_pressed("power_attack"):
		state_machine.travel("attack3")
	if Input.is_action_just_pressed("roll"):
		state_machine.travel("roll")
	
	if Input.is_action_pressed("block"):
		state_machine.travel("block_idle")
		velocity = Vector2.ZERO
	if hurt:
		state_machine.travel('hurt')
		hurt = false	
	if dead:
		state_machine.travel('death')
		velocity = Vector2.ZERO
			
		
	if velocity.x < 0:
		$Sprite.scale.x = -1
		$Position2D.scale.x = -1
		$Position2D2.scale.x = -1
	else:
		$Sprite.scale.x = 1
		$Position2D.scale.x = 1
		$Position2D2.scale.x = 1
	velocity = move_and_slide(velocity)
	


func _on_Hurtbox_area_entered(area):
	if not block:
		hurt = true
		health -=10
		if health <=0:
			dead = true


func _on_Defensebox_area_entered(area):
	block = true
	print('blocked!')


func _on_Defensebox_area_exited(area):
	block = false
