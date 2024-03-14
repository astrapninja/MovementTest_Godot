extends State
class_name PlayerJump

@export var player : CharacterBody2D

var jumpFalloffRate : float
var jumpStrength : float

func _Enter():
	
	jumpFalloffRate = player.jumpFalloffRate
	jumpStrength = player.jumpStrength
	
	player.velocity.y = -jumpStrength

func _Update(_delta : float):
	if player.velocity.y >= 0:
		Transitioned.emit(self, "Fall")

func _Physics_Update(_delta : float):
	player.velocity.y += jumpFalloffRate
