extends State
class_name PlayerSprint

@export var player : CharacterBody2D

var sprintSpeed : float
var sprintAccelerationRate : float

var acceleration : float

func _Enter():
	
	sprintSpeed = player.sprintSpeed
	sprintAccelerationRate = player.sprintAccelerationRate
	
	acceleration = sprintAccelerationRate
	
	if player.velocity.x < sprintSpeed - 50: # TODO: Replace this with dash
		var input_direction = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
		)
	
		player.velocity.x += input_direction[0] * (sprintSpeed/4)

func _Update(_delta : float):
	
	#Slide
	if !Input.get_action_strength("left") and !Input.get_action_strength("right"):
		#print("Slide")
		return
	elif Input.get_action_strength("left") and Input.get_action_strength("right"):
		#print("Slide")
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
	
	var input_direction = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	
	if player.velocity.x != input_direction[0] * sprintSpeed:
		player.velocity.x += (input_direction[0] * acceleration * _delta)
		acceleration += (acceleration*0.1)
		player.velocity.x = player.velocity.limit_length(sprintSpeed)[0]
		return
	
	return
	
