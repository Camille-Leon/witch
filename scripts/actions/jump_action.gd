extends Action

var jump_velocity: int = -600

var coyote_time_max: float = 0.1 # in seconds
var coyote_time: float = 0

var jump_buffer := false

var raycast: RayCast2D

func _init(new_owner: Node):
	super(new_owner)
	
	raycast = RayCast2D.new()
	raycast.collide_with_areas = true
	raycast.target_position.y = 32
	
	new_owner.add_child(raycast)

func jump():
	owner.velocity.y = float(jump_velocity)
	jump_buffer = false
	coyote_time = 0

func update(delta: float, new_triggered: bool):
	coyote_time -= delta
	
	var triggered_this_frame := false
	if !triggered and new_triggered:
		triggered_this_frame = true
	
	if owner.is_on_floor():
		coyote_time = coyote_time_max
		if jump_buffer:
			jump()

	if triggered_this_frame:
		if owner.is_on_floor():
			jump()
		else:
			if coyote_time > 0:
				jump()
			else:
				jump_buffer = raycast.is_colliding()
	
	triggered = new_triggered
