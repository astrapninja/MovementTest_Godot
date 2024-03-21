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
			player.velocity.x += (currentDirection * 50)
			lastDirection = currentDirection
			currentDirection = input_direction[0]

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
	
	input_direction = player.inputDirection
	
	#TODO: Make acceleration/deceleration smoother / fix math
	if player.velocity.x * currentDirection > walkSpeed:
		player.velocity.x -= (currentDirection * acceleration * _delta) #delete delta to make it instant
		acceleration += (acceleration*0.06)
		
		if player.velocity.x * currentDirection < walkSpeed:
			player.velocity.x = currentDirection * walkSpeed
		return
		
	elif player.velocity.x * currentDirection < walkSpeed:
		player.velocity.x += (currentDirection * acceleration) #delete delta to make it instant
		acceleration += (acceleration*0.08)
		player.velocity.x = player.velocity.limit_length(walkSpeed)[0]
		return
