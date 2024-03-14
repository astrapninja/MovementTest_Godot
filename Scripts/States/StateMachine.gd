extends Node

@export var initialState : State

var currentState : State
var states : Dictionary = {}

func _ready():
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.Transitioned.connect(_On_Child_Transition)
	
	print(states)
	
	if initialState:
		initialState._Enter()
		print("Entered ", initialState.name)
		currentState = initialState

func _process(delta):
	if currentState:
		currentState._Update(delta)

func _physics_process(delta):
	if currentState:
		currentState._Physics_Update(delta)

func _On_Child_Transition(state, newStateName):
	if state != currentState:
		return
	
	var newState = states.get(newStateName.to_lower())
	if !newState:
		return
	
	if currentState:
		currentState._Exit()
	
	newState._Enter()
	
	currentState = newState
	print("\nEntered ", currentState.name)
	
	pass
