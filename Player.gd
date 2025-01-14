extends CharacterBody2D

var wall_slide_timer = 0.0
var is_wall_sliding = false

#Movement variables
const SPEED = 250.0
const JUMP_VELOCITY = -400.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var anim = $AnimationPlayer
@onready var sprite = $PlayerSprite
@onready var swordHitBox = $PlayerSprite/SwordArea

# Animation constants
const IDLE_ANIMATION = "idle"
const RUN_ANIMATION = "run"
const FALL_ANIMATION = "fall"
const JUMP_ANIMATION = "jump"
const ATTACK_ANIMATION = "attack-1"
const AIR_ATTACK_ANIMATION = "air-attack-1"

var is_jumping = false
var is_attacking = false

func _ready():
	$PlayerSprite/SwordArea/SwordHitBox.disabled = true
	anim.play(IDLE_ANIMATION)

func _physics_process(delta):
	if not Game.is_in_dialogue and not Game.player_stopped:
		# Gravity handling
		var direction = Input.get_axis("left", "right")
		if (not is_on_floor() and not is_on_wall()) or is_on_floor():
			is_wall_sliding = false
			velocity.y += gravity * delta

		if is_on_wall() and not is_attacking:
			if velocity.y > 0 and wall_slide_timer:
				is_wall_sliding = true
			else:
				is_wall_sliding = false
				wall_slide_timer += delta
			#Wall sliding physics
			if is_wall_sliding:
				velocity.y += (gravity / 10) * delta
			else:
				velocity.y += gravity * delta
		# Jump
		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = JUMP_VELOCITY

		# Smaller jump if wall sliding
		if Input.is_action_just_pressed("jump") and is_on_wall():
			velocity.y = JUMP_VELOCITY/2
			#Direction based launch
			velocity.x = JUMP_VELOCITY * direction

		# Horizontal movement
		if direction != 0:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)

		# Movement and animation
		if not is_attacking:
			handle_movement(direction)
		handle_attack()
		check_sword_collisions()
		move_and_slide()
		

func handle_movement(direction: float):
	# Floor animations
	if is_on_floor() and not is_attacking:
		if direction != 0:
			anim.play(RUN_ANIMATION)
		else:
			anim.play(IDLE_ANIMATION)
	else:
		# Air animations
		if not is_on_wall():
			if velocity.y > 0: #Falling
				is_jumping = false
				anim.play(FALL_ANIMATION)
			elif velocity.y < 0: #If coming off a wall jump
				anim.play(JUMP_ANIMATION)
			else: #Regular jumping
				if !is_jumping:
					anim.play(JUMP_ANIMATION)
					is_jumping = true
		else:
			anim.play("wall-slide")

	# Flip the sprite based on the sign of 'direction'
	handleDirection(direction)

func handleDirection(direction: float):
	if direction > 0 and sprite.flip_h == true:
		#Right
		sprite.flip_h = false
		swordHitBox.scale.x = 1 #return sword hit area to default position
	elif direction < 0 and sprite.flip_h == false:
		#Left
		sprite.flip_h = true
		swordHitBox.scale.x = -1 #flip sword area to match sprite

func handle_attack():
	if not is_attacking:
		if Input.is_action_just_pressed("attack"):
			is_attacking = true
			if is_on_floor():
				anim.play(ATTACK_ANIMATION)
			else:
				anim.play(AIR_ATTACK_ANIMATION)
			await anim.animation_finished
			is_attacking = false

##
#  New function: Checks for overlapping bodies in the SwordHitBox,
#  calls getCharName() if it exists, and pushes them away if they are in Game.ENEMIES.
##
func check_sword_collisions():
	var bodies = swordHitBox.get_overlapping_bodies()
	for body in bodies:
		# 1. Check if the body has a getCharName() function.
		if body.has_method("getCharName"):
			var enemy_name = body.getCharName()

			# 2. If the name is in the Game.ENEMIES list, push them away.
			if enemy_name in Game.ENEMIES:
				push_enemy_away(body)
				body.apply_damage(2)

func push_enemy_away(enemy):
	var push_direction = global_position.direction_to(enemy.global_position)
	var push_force = 300.0
	enemy.apply_knockback(push_direction, push_force, 0.3)

