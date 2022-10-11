extends KinematicBody2D


var speed = 200
var velocity
onready var state_machine = $AnimationTree.get("parameters/playback")

func _process(delta):
	velocity = Vector2.ZERO
	
	if Input.is_action_pressed("ui_left"):
		velocity = Vector2.RIGHT*(-speed)	
		state_machine.travel("run")
		$Sprite.scale.x = -1
		
	elif Input.is_action_pressed("ui_right"):
		velocity = Vector2.RIGHT*speed
		state_machine.travel("run")
		$Sprite.scale.x = 1
		
	position += velocity*delta	
		
		
			
		
		
		
		
		
