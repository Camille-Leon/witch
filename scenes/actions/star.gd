extends Node2D

@onready var sprite := $Sprite
@onready var area := $Area
@onready var explosion_particles := $ExplosionParticles
@onready var sparkle_particles := $SparkleParticles

var velocity := Vector2(0, 0)
var bouncing: bool = false

func _ready() -> void:
	explosion_particles.emitting = true

func explode() -> void:
	sprite.visible = false
	
	var sparkle_particles_children = sparkle_particles.get_children()
	for child in sparkle_particles_children:
		child.emitting = false
	
	explosion_particles.emitting = true

func _process(delta: float) -> void:
	position += velocity
	sprite.rotation += 4 * delta
	
	if bouncing:
		sprite.rotation += 4 * delta
		velocity.x = move_toward(velocity.x, 0, 50 * delta)
		velocity.y = move_toward(velocity.y, 0, 50 * delta)
		sprite.scale += Vector2(4, 4) * delta 
		
		if velocity == Vector2.ZERO and sprite.visible:
			explosion_particles.restart()
			explode()
	
	if sprite.visible == false and !explosion_particles.emitting:
		queue_free()
		
	if area.has_overlapping_bodies() and !bouncing:
		bouncing = true
		explosion_particles.emitting = true
		velocity *= Vector2(-2, -2)
		velocity.y += randf_range(-2, 2)
