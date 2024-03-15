extends State
class_name PlayerStandSlide

@export var player : CharacterBody2D

var deceleration : float
var decelerationRate : float = 2.5
var lastXDirection : int
var velocityThreshold : float

func _Enter():
	
	deceleration = decelerationRate
	lastXDirection = player.lastXDirection
	velocityThreshold = player.standSlideSprint

func _Exit():
	pass

func _Update(_delta : float):
	pass

func _Physics_Update(_delta: float):
	
	player.velocity.x -= deceleration * lastXDirection
	deceleration += decelerationRate
	
	print(player.velocity.x)
