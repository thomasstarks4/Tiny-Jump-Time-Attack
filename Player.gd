extends CharacterBody2D

var wall_slide_cooldown = 0.5 # Cooldown time in seconds before wall sliding starts
var wall_slide_timer = 0.0
var is_wall_sliding = false
const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if (not is_on_floor() and not is_on_wall() or is_on_floor()):
		is_wall_sliding = false  # Exit wall slide if not on a wall or if on the floor
		velocity.y += gravity * delta
	
	if is_on_wall():
		# Check if wall sliding should start
		if velocity.y > 0 and wall_slide_timer >= wall_slide_cooldown:
			is_wall_sliding = true
		else:
			is_wall_sliding = false
			wall_slide_timer += delta

		# Apply wall sliding effect
		if is_wall_sliding:
			velocity.y += (gravity / 10) * delta  # Reduced gravity for slower descent
		else:
			velocity.y += gravity * delta  # Normal gravity until sliding starts
	
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Reset wall_slide_timer on jump
	if Input.is_action_just_pressed("jump") and is_on_wall():
		pass
	# Get the input direction and handle the movement/deceleration.
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
func incrementCooldowns(delta):
	if not is_wall_sliding:
		wall_slide_timer += delta
	else:
		wall_slide_timer = 0.0
