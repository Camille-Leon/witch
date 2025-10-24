extends CharacterBody2D
class_name Player

var state_machine: StateMachine = StateMachine.new()

var move_speed: int = 350
var jump_velocity: int = -700

var facing: int = 1

@onready var sprite := $Sprite

var can_move := true
var can_jump := true
var apply_gravity := true

var primary_action: Action
var secondary_action: Action

enum PlayerState {
	IDLE
}

func _ready() -> void:
	#state_machine.add(PlayerState.IDLE, State.new().set_update(func(_delta: float):
		#print("Are you on the ground? " + str(is_on_floor()))
	#))
	
	primary_action = Actions.get_action("jump").new(self)
	secondary_action = Actions.get_action("star").new(self)

func _physics_process(delta: float) -> void:
	var input_horizontal = Input.get_axis("left", "right")
	
	var input_primary = Input.is_action_pressed("primary")
	var input_secondary = Input.is_action_pressed("secondary")
	
	if primary_action:
		primary_action.update(delta, input_primary)
	
	if secondary_action:
		secondary_action.update(delta, input_secondary)
	
	if !is_on_floor():
		if apply_gravity:
			velocity += get_gravity() * delta
	
	if can_move:
		if abs(input_horizontal) == 1:
			if input_horizontal == 1:
				sprite.flip_h = false
			else:
				sprite.flip_h = true
			sprite.animation = "move"
			velocity.x = move_toward(velocity.x, input_horizontal * move_speed, 3000 * delta)
			facing = int(input_horizontal)
		else:
			sprite.animation = "idle"
			velocity.x = move_toward(velocity.x, 0, 4000 * delta)
	
	#state_machine.update(delta)
	
	move_and_slide()
