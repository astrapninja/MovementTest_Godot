extends State
class_name PlayerSprint

@export var player : CharacterBody2D

var acceleration : float
var inputDirection : Vector2
var sprintSpeed : float
var sprintAccelerationTime : float

func _Enter():
	
	acceleration = 0
	sprintSpeed = player.sprintSpeed
	sprintAccelerationTime = ((sprintSpeed-(player.velocity.x*player.inputDirection[0]))/sprintSpeed)*player.sprintAccelerationTime
	#print(sprintAccelerationTime, " ", player.velocity.x, " ", sprintSpeed)
	
	inputDirection = player.inputDirection
	
	if player.velocity.x < sprintSpeed - 50: # TODO: Replace this with dash
		player.velocity.x += inputDirection[0] * (sprintSpeed/4)

func _Update(_delta : float):
	
	#Slide
	if !Input.get_action_strength("left") and !Input.get_action_strength("right"):                                             
		Transitioned.emit(self, "StandSlide")
		return
	elif Input.get_action_strength("left") and Input.get_action_strength("right"):
		Transitioned.emit(self, "StandSlide")
		return
	
	#Walk
	if !Input.get_action_strength("sprint"):
		Transitioned.emit(self, "Walk")
		return

	#Jump
	if Input.get_action_strength("jump"):
		Transitioned.emit(self, "Jump")
		return

func _Physics_Update(_delta : float):
	
	var accel = 0
	
	if sprintAccelerationTime > 0:
		var difference = (abs(player.velocity.x) - sprintSpeed)
		accel = difference/ sprintAccelerationTime*_delta
		
		player.velocity.x -= accel*inputDirection[0]
		
		sprintAccelerationTime -= _delta
		#print(abs(accel)*inputDirection[0], " ", player.velocity.x, " ", sprintAccelerationTime)
	
	inputDirection = player.inputDirection
	
	#if player.velocity.x != inputDirection[0] * sprintSpeed:
		#player.velocity.x += (inputDirection[0] * acceleration * _delta)
		#acceleration += (acceleration*0.1)
		#player.velocity.x = player.velocity.limit_length(sprintSpeed)[0]
		#return
	
	return
