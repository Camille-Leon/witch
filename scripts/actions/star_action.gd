extends Action

const BIGSTAR_SCENE = preload("res://scenes/actions/bigstar.tscn")
const SMALLSTAR_SCENE = preload("res://scenes/actions/smallstar.tscn")

var firerate_max := 0.25
var firerate = 0

func update(delta: float, new_triggered: bool):
	if !triggered and new_triggered:
		firerate = firerate_max
		var star := BIGSTAR_SCENE.instantiate()
		star.velocity = Vector2(owner.facing * 3, 0)
		star.position = owner.position + Vector2(0, -32)
		owner.get_tree().root.add_child(star)
	if new_triggered:
		firerate -= delta
		if firerate <= 0:
			firerate = firerate_max
			var star := SMALLSTAR_SCENE.instantiate()
			star.velocity = Vector2(owner.facing * 3, 0)
			star.position = owner.position + Vector2(0, -32)
			owner.get_tree().root.add_child(star)
	
	triggered = new_triggered
