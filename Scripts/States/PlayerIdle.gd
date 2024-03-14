extends State
class_name PlayerIdle

@export var player : CharacterBody2D

var timeIdled : float

func _Enter():
	
	#TODO: Make it so velocity.x isn't changed for like 0.1 seconds or something after entering Idle
	
	timeIdled = 0
	
func _Update(_delta : float):
	
	#Walk
	if (Input.get_action_strength("left") or Input.get_action_strength("right")) and !(Input.get_action_strength("left") and Input.get_action_strength("right")):
		if Input.get_action_strength("sprint"):
			Transitioned.emit(self, "Sprint") # TODO: Change this to Dash and have Dash continue to run
		else:
			Transitioned.emit(self, "Walk")
		return
	
	#Jump
	if Input.get_action_strength("jump"):
		Transitioned.emit(self, "Jump")
		return
	
	#Fall
	if !player.is_on_floor():
		Transitioned.emit(self, "Fall")
		return

func _Physics_Update(_delta : float):
	timeIdled += _delta
	
	if timeIdled > 0.1 and player.velocity != Vector2.ZERO:
		player.velocity += -(player.velocity * 1)
	
	if timeIdled >= 5:
		# Play a special Idle anim
		timeIdled = 0
