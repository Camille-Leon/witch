class_name Actions

const ACTIONS = {
	"jump": preload("res://scripts/actions/jump_action.gd")
}

static func get_action(name: String) -> Script:
	if ACTIONS.has(name):
		return ACTIONS[name]
	return null
