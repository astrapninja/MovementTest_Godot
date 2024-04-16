extends State
class_name PlayerJump

@export var player : CharacterBody2D

var jumpFalloffRate : float
var jumpStrength : float

func _Enter():
	
	jumpFalloffRate = player.jumpFalloffRate
	jumpStrength = player.jumpStrength
	
	if player.lastState.name != "StandSlide":
		player.velocity.y = -jumpStrength
		#print("\n\t --", player.currentState, "\n")
	else:
		player.velocity.y = -jumpStrength*1.5
		#print("\n\t--Ye it works\n")

func _Update(_delta : float):
	if player.velocity.y >= 0:
		Transitioned.emit(self, "Fall")

func _Physics_Update(_delta : float):
	player.velocity.y += jumpFalloffRate
