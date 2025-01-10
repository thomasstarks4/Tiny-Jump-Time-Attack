extends HBoxContainer

@onready var heart_scene = preload("res://ui elements/health_rune.tscn")  # Path to your Heart.tscn
@onready var darkened_heart_scene = preload("res://ui elements/darkened_health_rune.tscn")  # Path to your DarkenedHeart.tscn
@onready var player_hp = Game.playerHP

var initialized = false
var base_pos = 20  # Base position for the first heart
var heart_spacing = 40  # Space between hearts

func _ready():
	update_hearts()
	initialized = true

func _process(_float):
	if player_hp != Game.playerHP:
		update_hearts()

# Function to update the hearts display
func update_hearts():
	# Clear current hearts
	for child in get_children():
		child.queue_free()
	
	# Play sound effects if initialized
	if initialized:
		if player_hp > Game.playerHP:
			$"../HealthDrainedPlayer".play()
		elif player_hp < Game.playerHP:
			var rng = RandomNumberGenerator.new()
			var random_num = rng.randi_range(1, 3)
			match random_num: #Play one of three possible sound effects for health changes
				1:
					$"../HealthRestorePlayer1".play()
				2:
					$"../HealthRestorePlayer2".play()
				3:
					$"../HealthRestorePlayer3".play()
	
	# Track the current position for heart placement
	var current_pos = base_pos

	# Add filled hearts for current health
	for i in range(Game.playerHP):
		var heart = heart_scene.instantiate()
		add_child(heart)
		heart.position.x = current_pos
		heart.position.y = 25
		current_pos += heart_spacing
		print("Added heart:", i, "at position:", heart.position)  # Debug

	# Add darkened hearts for missing health
	var missing_hp = Game.playerMaxHP - Game.playerHP
	for j in range(missing_hp):
		var missing_heart = darkened_heart_scene.instantiate()
		add_child(missing_heart)
		missing_heart.position.x = current_pos
		missing_heart.position.y = 25
		current_pos += heart_spacing
		print("Added darkened heart:", j, "at position:", missing_heart.position)  # Debug

	# Update the tracked player HP
	player_hp = Game.playerHP
