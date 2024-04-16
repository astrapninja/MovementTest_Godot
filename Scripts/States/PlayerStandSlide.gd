extends State
class_name PlayerStandSlide

@export var player : CharacterBody2D

var deceleration : float
var decelerationRate : float = 11.5
var lastXDirection : int
var velocityThreshold : float

func _Enter():
	
	deceleration = decelerationRate
	lastXDirection = player.lastXDirection
	velocityThreshold = player.standSlideSprint

func _Exit():
	pass

#TODO: Connect StandSlide to Walk, Jump and Fall States
func _Update(_delta : float):
	
	var input_direction = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	
	if Input.get_action_strength("jump"):
		Transitioned.emit(self, "Jump")
		return
	
	if Input.get_action_strength("sprint") and (Input.get_action_strength("left") or Input.get_action_strength("right")) and !(Input.get_action_strength("left") and Input.get_action_strength("right")):
		if player.velocity.x * lastXDirection < velocityThreshold:
			player.velocity.x += input_direction[0] * 150
			Transitioned.emit(self, "Sprint")
			return
	
	pass

func _Physics_Update(_delta: float):
	
	if player.velocity.x * lastXDirection > velocityThreshold:
		player.velocity.x -= (deceleration*_delta) * lastXDirection
		deceleration += decelerationRate
