extends Node
class_name StateMachine

var state_map: Dictionary = {}
var current_state: State
var current_state_index: int = -1

func add(state_index: int, state: State) -> void:
	state_map.set(state_index, state)
	if current_state_index == -1:
		current_state = state
		current_state_index = state_index
		if current_state.entered.is_valid():
			current_state.entered.call()

func remove(state_index: int) -> void:
	state_map.erase(state_index)

func change(state_index: int) -> void:
	if current_state.exited.is_valid():
		current_state.exited.call(state_index)
		
	current_state = state_map.get(state_index)
	
	if current_state.entered.is_valid():
		current_state.entered.call(current_state_index)
		
	current_state_index = state_index

func update(delta: float) -> void:
	if current_state.update.is_valid():
		current_state.update.call(delta)
