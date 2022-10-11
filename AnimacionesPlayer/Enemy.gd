extends KinematicBody2D

export(int) var w_range = 50

var speed = 100
var accel = 4
var velocity = Vector2.ZERO
onready var state_machine = $AnimationTree.get("parameters/playback")
onready var timer = $Timer

onready var start_position = global_position #Donde empieza el jugadopr
onready var target_position = global_position #Donde se quiere que llegue

func update_target_position():
	var target_vector = Vector2(rand_range(-w_range, w_range), rand_range(-w_range, w_range))
	target_position = start_position
	state_machine.travel('Walk')

func _physics_process(delta):
	var direction = global_position.direction_to(target_position) #Calcular la direccion hacia el destino
	if direction.x < 0: #Para darle la vuelta al script
		$Sprite.scale.x = -1
	else:
		$Sprite.scale.x = 1
	velocity = velocity.move_toward(direction*speed, accel)
	if global_position.distance_to(target_position) < 0.1:
		state_machine.travel('idle')
		velocity = Vector2.ZERO
	move_and_slide(velocity)		
			

func _on_Timer_timeout():
	print("Timeout!")
	var duration = rand_range(3,7)
	#Reproducir animacion de attack
	state_machine.travel("Attack")
	timer.start(duration)
