extends State
class_name PlayerWalk

@export var player : CharacterBody2D

var walkAccelerationRate : float
var walkSpeed : float

var acceleration : float
var lastDirection : float

func _Enter():
	
	var input_direction = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
		)
	
	walkAccelerationRate = player.walkAccelerationRate
	walkSpeed = player.walkSpeed
	
	acceleration = walkAccelerationRate
	lastDirection = input_direction[0]
	
	if player.velocity.x * input_direction[0] < walkSpeed-50:
	
		player.velocity.x += (input_direction[0] * 50)
	else:
		player.velocity.x = player.velocity.x

func _Update(_delta : float):
	
	#Idle
	if !Input.get_action_strength("left") and !Input.get_action_strength("right"):
		Transitioned.emit(self, "Idle")
		return
	elif Input.get_action_strength("left") and Input.get_action_strength("right"):
		Transitioned.emit(self, "Idle")
		return
	
	#Sprint
	if Input.get_action_strength("sprint"):
		Transitioned.emit(self, "Sprint")
		return
	
	#Jump
	if Input.get_action_strength("jump"):
		Transitioned.emit(self, "Jump")
		return

func _Physics_Update(_delta : float):
	
	var input_direction = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	
	if input_direction[0] != lastDirection:
		player.velocity.x += (input_direction[0] * 50)
		lastDirection = input_direction[0]
	
	#TODO: Make acceleration/deacceleration smoother / fix math
	if player.velocity.x * input_direction[0] > walkSpeed:
		player.velocity.x -= (input_direction[0] * acceleration * _delta) #delete delta to make it instant
		acceleration += (acceleration*0.06)
		
		if player.velocity.x * input_direction[0] < walkSpeed:
			player.velocity.x = input_direction[0] * walkSpeed
		return
		
	elif player.velocity.x * input_direction[0] < walkSpeed:
		player.velocity.x += (input_direction[0] * acceleration) #delete delta to make it instant
		acceleration += (acceleration*0.08)
		player.velocity.x = player.velocity.limit_length(walkSpeed)[0]
		return
