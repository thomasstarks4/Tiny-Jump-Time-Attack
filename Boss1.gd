extends CharacterBody2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var anim = get_node("AnimationPlayer")
@onready var sprite = $BossSprite
var chase = false
var SPEED = 50
var isDead = false
var HP = 5
var count = 0
var cooldown = 0
var damageCooldown = 0
var knockbackCooldown = 90
var isfrog = true
var charName = "Boss1"
var damaging = false
var currentTarget
var knockback_timer = 0.0
var knockback_velocity = Vector2.ZERO
var is_knocked_back = false
const DEFENSE = 1

func _ready():
	anim.play("idle")
	
func _physics_process(delta):
	if isDead:
		return
	#Knockback Effect
	if is_knocked_back:
		knockback_timer -= delta
		velocity = knockback_velocity
		move_and_slide()

		# Once the timer expires, revert to normal
		if knockback_timer <= 0:
			is_knocked_back = false
		return
	damageCooldown += 1
	
	velocity.y += gravity * delta
	if chase:
		handleChasing()
	else:
		velocity.x = 0
		anim.play("idle")	
	amIAlive()
	move_and_slide()
			
func getCharName():
	return charName

func handleChasing():
	var current_scene = get_tree().get_current_scene()
	if current_scene == null:
		return
	var player = current_scene.get_node_or_null("Player")
	if player == null:
		return
	var direction = player.position - position
	if direction.length() > 0:
		direction = direction.normalized()
	handleDirection(direction.x)

	# Set chase velocity, but do NOT manually update position.
	velocity.x = direction.x * SPEED
	velocity.y = direction.y * SPEED
	

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
		#var rng = RandomNumberGenerator.new()
		#var randomNum = rng.randi_range(0, 5)
		#var lootRoll = rng.randi_range(1, 10)
		#Game.killed_enemy(5, randomNum, lootRoll, self.position, "Frog")
		#get_node("AnimatedSprite2D").play("death")
		#var tween1 = get_tree().create_tween()
		#tween1.tween_property(self, "modulate:a", 0, 0.35)
		#await get_node("AnimatedSprite2D").animation_finished
		self.queue_free()

func amIAlive():
	if self.HP <= 0:
		damaging = false
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
		var player = body
		damaging = true
		currentTarget = player

func _on_player_collision_body_exited(_body: Node2D) -> void:
	damaging = false

func handleDirection(direction: float): #Bat normally faces left
	if direction > 0 and sprite.flip_h == false:
		#Left
		sprite.flip_h = true
	elif direction < 0 and sprite.flip_h == true:
		#Right
		sprite.flip_h = false

func apply_knockback(dir: Vector2, force: float, duration: float):
	is_knocked_back = true
	knockback_timer = duration
	knockback_velocity = dir * force
	
	
func apply_damage(amount):
	if damageCooldown < 10:
		return
	else:
		HP -= (amount - DEFENSE)
		damageCooldown = 0
