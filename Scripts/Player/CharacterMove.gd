extends CharacterBody2D

@export var coyoteJumpTime : float
@export var gravityAccelerationRate : float
@export var gravityMaxVelocity : float
@export var hasDoubleJumped : bool
@export var jumpFalloffRate : float
@export var jumpStrength : float
@export var lastXDirection : int
@export var sprintAccelerationRate : float
@export var sprintSpeed : float
@export var standSlideSprint : float
@export var walkAccelerationRate : float
@export var walkSpeed : float

#Fix all player code(i.e. States)

#TODO: Redo Jumping - all states will apply impulse velocity if they can jump. Jump state will only decrease the velocity. or make fall do it idc which
func _physics_process(delta : float):
	
	var input_direction = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	
	if lastXDirection != input_direction[0] and input_direction[0] != 0:
		lastXDirection = int(input_direction[0]) #I only did the int() to shut up a warn. I don't like the caution triangle.
	
	move_and_slide()
