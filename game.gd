extends Node

#Game Mechanic Variables
var is_wallsliding_enabled = false
var is_dashing_enabled = false
@onready var playerMaxHP = 5
@onready var playerHP = playerMaxHP
var playerHealthRegen = 0

func _ready():
	reset_cooldowns()

func _process(delta):
	track_cooldowns(delta)
	
func track_cooldowns(delta):
	if playerHP < playerMaxHP: #Regen does not start if player is at max HP
		playerHealthRegen += (delta) #30 frames = 1 second
		if playerHealthRegen > 15: #1 HP is regenerated every 15 seconds
			if Game.playerHP < playerMaxHP:
				playerHP += 1
				playerHealthRegen = 0

func reset_cooldowns(type = null):
	if type == null: #Then reset all cooldowns
		playerHealthRegen = 0
	else:
		match(type): #Only reset a specific cooldown Ex: Game.reset_cooldowns("HP") resets HP Regen cooldown
			"HP":
				playerHealthRegen = 0


#Linear Gamestate Variables
var show_graveri = false
var graveri_attacked = true
var intro_dialogue_complete = false
var level_one_dialogue_finished = false
