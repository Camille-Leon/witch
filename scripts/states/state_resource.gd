extends Resource
class_name State

const EMPTY_CALLABLE: Callable = Callable()

var entered: Callable
var update: Callable
var exited: Callable

func _init(
	new_entered: Callable = EMPTY_CALLABLE,
	new_update: Callable = EMPTY_CALLABLE,
	new_exited: Callable = EMPTY_CALLABLE
) -> void:
	entered = new_entered
	update = new_update
	exited = new_exited

func set_entered(new_entered: Callable) -> State:
	entered = new_entered
	return self

func set_update(new_update: Callable) -> State:
	update = new_update
	return self

func set_exited(new_exited: Callable) -> State:
	exited = new_exited
	return self
