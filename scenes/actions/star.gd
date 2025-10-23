extends Node2D

@onready var sprite := $Sprite
var velocity := Vector2(0, 0)

func _process(delta: float) -> void:
	position += velocity
	sprite.rotation += 2.5 * delta
