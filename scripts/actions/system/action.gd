class_name Action

var owner: Node
var triggered: bool

func _init(new_owner: Node):
	owner = new_owner

func update(delta: float, new_triggered: bool): pass
