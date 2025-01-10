extends CharacterBody2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var anim = get_node("AnimationPlayer")
var player
var chase = false
var SPEED = 50
var isDead = false
var HP = 1
var count = 0
var cooldown = 0
var damageCooldown = 0
var knockbackCooldown = 90
var isfrog = true
var charName = "Frog"
var damaging = false
var currentTarget

func _ready():
	anim.play("idle")

func _physics_process(delta):
	if not isDead:
		damageCooldown += 1
		velocity.y += gravity * delta
		if chase:
			handleChasing(delta)
		move_and_slide()
		if not chase:
			anim.play("idle")	
			velocity.x = 0
		amIAlive()
		if damaging and damageCooldown > 90: #This damages the player every 1.5 seconds. Adjust if needed
			#player.takeDamage(1)
			damageCooldown = 0
			# Knockback effect	
			#if the player is not near a wall and would get stuck, an area2D must be added in the level aa a boundary.
			#still figuring out how i'm going to make this a thing because the previous attempt with
			#an area2d did not work
#			if Game.canKnockbackPlayer:
			#if not Game.playerIsNearWall:
				#var knockback_distance = 20  # Adjust this value as needed
				#var direction = sign(currentTarget.position.x - self.position.x)  # Get the sign of the x-direction
				#currentTarget.position.x += direction * knockback_distance
				#player.knockbackCooldown = 0
			
func getCharName():
	return charName

func handleChasing(_delta):
	#anim.play("run")  # Play the running animation
	var player = get_node("../Player")  # Get the player node

	# Calculate the direction to the player
	var direction = (player.position - self.position).normalized()
	
	# Flip sprite based on direction
	if direction.x > 0:
		$BossSprite.scale.x = -1
	else:
		$BossSprite.scale.x = 1

	# Update velocity based on direction and speed
	velocity.x = direction.x * SPEED

	# Smoothly move the enemy towards the player
	position += velocity * _delta


#If the player is close enough, they'll chase the player
func _on_player_detection_area_body_entered(body):
		if body.name == "Player":
			chase = true

#If the player gets enough distance, they'll stop chasing the player
func _on_player_detection_area_body_exited(body):
	if body.name == "Player":
		chase = false

func death():
	if isDead == true:
		return
	else:
		isDead = true
		chase = false
		set_collision_layer(0)
		var rng = RandomNumberGenerator.new()
		var randomNum = rng.randi_range(0, 5)
		var lootRoll = rng.randi_range(1, 10)
		#Game.killed_enemy(5, randomNum, lootRoll, self.position, "Frog")
		#get_node("AnimatedSprite2D").play("death")
		#var tween1 = get_tree().create_tween()
		#tween1.tween_property(self, "modulate:a", 0, 0.35)
		#await get_node("AnimatedSprite2D").animation_finished
		self.queue_free()

func amIAlive():
	if self.HP < 1:
		damaging = false
		get_parent().frog_count -= 1
		death()
	else:
		isDead = false

func takeDamage(amount):
	HP -= amount
	
		
#Makes them instantly die and launch player up a bit if player jumps on their head.
#Will need to be reconnected, but saving to use elsewhere.
func _on_player_death_body_entered(body):
	if body.name == "Player":
		death()
		body.velocity.y -= 150

#need to take the below function and refactor it to a function called StartDamage()
#this StartDamage function will apply the damage over time by setting a boolean variable
#to true.
func _on_player_collision_body_entered(body):
	if body.name == "Player":
		player = get_node("../../Player/Player")
		damaging = true
		currentTarget = player

func _on_player_collision_body_exited(_body: Node2D) -> void:
	damaging = false



