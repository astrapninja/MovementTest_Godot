extends State
class_name PlayerWalk

@export var player : CharacterBody2D

var acceleration : float
var currentDirection : float
var input_direction : Vector2
var lastDirection : float
var walkAccelerationRate : float
var walkSpeed : float

func _Enter():
	
	input_direction = player.inputDirection
	
	acceleration = walkAccelerationRate
	currentDirection = input_direction[0]
	walkAccelerationRate = player.walkAccelerationRate
	walkSpeed = player.walkSpeed
	
	if player.velocity.x * currentDirection < walkSpeed-50:
		player.velocity.x += (currentDirection * 50)
	else:
		player.velocity.x = player.velocity.x

func checkDirection():
		if input_direction[0] != currentDirection:
			lastDirection = currentDirection
			currentDirection = input_direction[0]
			print(currentDirection, " ", input_direction)
			#print("..........\n", player.velocity.x,"\n\n", input_direction[0], "\n", (player.velocity.x * input_direction[0])*2,"\n..........")
			player.velocity.x += (player.velocity.x * currentDirection)*2
			#print("--------------\n", player.velocity.x,"\n\n",(player.velocity.x * currentDirection)*2,"\n--------------")

func _Update(_delta : float):
	
	#Idle
	if !Input.get_action_strength("left") and !Input.get_action_strength("right"):
		Transitioned.emit(self, "Idle")
		return
	elif Input.get_action_strength("left"):	
		checkDirection()
	else:
		checkDirection()
	
	#Sprint
	if Input.get_action_strength("sprint"):
		Transitioned.emit(self, "Sprint")
		return
	
	#Jump
	if Input.get_action_strength("jump"):
		Transitioned.emit(self, "Jump")
		return

func _Physics_Update(_delta : float):
	
	#print(player.velocity.x)
	
	input_direction = player.inputDirection
	print('--------------\ninput_direction :\t\t', input_direction,'--------------\nplayer.inputDirection :\t', player.inputDirection)
	
	#TODO: Make acceleration/deceleration smoother / fix math
	if player.velocity.x * currentDirection > walkSpeed:
		player.velocity.x -= (currentDirection * acceleration * _delta) #delete delta to make it instant
		acceleration += (acceleration*0.06)
		
	elif player.velocity.x * currentDirection < walkSpeed:
		player.velocity.x += (currentDirection * acceleration) #delete delta to make it instant
		acceleration += (acceleration*0.08)
		#print(acceleration)
		player.velocity.x = player.velocity.limit_length(walkSpeed)[0]
		return
