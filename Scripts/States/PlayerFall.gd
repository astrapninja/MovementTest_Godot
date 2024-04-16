extends State
class_name PlayerFall

@export var player : CharacterBody2D

var gravityAccelerationRate : float
var gravityMaxVelocity : float
var coyoteJumpTime : float

var acceleration : float = 0.0
var coyoteTime : float = 0.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _Enter():
	
	#print(player.gravityAccelerationRate)
	gravityAccelerationRate = player.gravityAccelerationRate
	gravityMaxVelocity = player.gravityMaxVelocity
	coyoteJumpTime = player.coyoteJumpTime
	
	acceleration = 0.0

func _Exit():
	player.hasDoubleJumped = false

func _Update(_delta : float):
	
	#Jump (Coyote Time)
	if coyoteTime <= coyoteJumpTime and !player.hasDoubleJumped:
		if Input.get_action_strength("jump"):
			Transitioned.emit(self, "Jump")
	#Double Jump
	elif Input.get_action_strength("jump") and !player.hasDoubleJumped:
		Transitioned.emit(self, "Jump")
		player.hasDoubleJumped = true
	
	if player.is_on_floor() and (!(Input.get_action_strength("left") or Input.get_action_strength("right")) or (Input.get_action_strength("left") and Input.get_action_strength("right"))):
		Transitioned.emit(self, "Idle")
		player.velocity.x = 0
		
	elif player.is_on_floor() and (Input.get_action_strength("left") or Input.get_action_strength("right")) and !(Input.get_action_strength("left") and Input.get_action_strength("right")):
		Transitioned.emit(self, "Walk")

func _Physics_Update(_delta: float):
	
	if !player.hasDoubleJumped:
		coyoteTime += _delta
	
	if !player.is_on_floor():
		if player.velocity.y != gravityMaxVelocity:
			player.velocity.y += (gravity*gravityAccelerationRate) * _delta
		
		if player.velocity.y > gravityMaxVelocity:
			player.velocity.y = gravityMaxVelocity
		
		if player.velocity.x > 0:
			player.velocity.x -= (gravity*0.025) * _delta
		elif player.velocity.x < 0:
			player.velocity.y += (gravity*0.025) * _delta
		
