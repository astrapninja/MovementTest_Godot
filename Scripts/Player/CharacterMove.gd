extends CharacterBody2D

@export var coyoteJumpTime : float
@export var gravityAccelerationRate : float
@export var gravityMaxVelocity : float
@export var hasDoubleJumped : bool
@export var jumpFalloffRate : float
@export var jumpStrength : float
@export var sprintAccelerationRate : float
@export var sprintSpeed : float
@export var walkAccelerationRate : float
@export var walkSpeed : float

#Fix all player code(i.e. States)
func _physics_process(delta):
	
	move_and_slide()
