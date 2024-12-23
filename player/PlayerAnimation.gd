extends AnimatedSprite2D

# Constants for readability
const IDLE_ANIMATION = "idle"
const RUN_ANIMATION = "run"
const FALL_ANIMATION = "fall"

# Called when the node enters the scene tree for the first time.
func _ready():
	play(IDLE_ANIMATION)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	handle_movement()


func handle_movement():
	# Reference to the parent node for movement checks
	var parent = $".."
	
	# Check if the parent node is on the floor
	if parent.is_on_floor():
		# Determine the animation based on input
		if Input.is_action_pressed("right") or Input.is_action_pressed("left"):
			play(RUN_ANIMATION)
		else:
			play(IDLE_ANIMATION) # Default to idle if no movement key is pressed
	else:
		# Play 'fall' animation when not on the floor
		play(FALL_ANIMATION)
		handleDirection()
	handleDirection()
# Flip the sprite based on direction
func handleDirection():
	if Input.is_action_pressed("right"):
		self.flip_h = false
	if Input.is_action_pressed("left"):
		self.flip_h = true
