extends Node2D

@onready var music_player = $AudioStreamPlayer2D
var music_begin = false
var music_started = false
# Called when the node enters the scene tree for the first time.
func _ready():
	$Player/Camera2D.limit_bottom = 280
	$Player/Camera2D.limit_left = 0
	$Player/Camera2D.limit_right = 525
	$Player/Camera2D.limit_top = -226 	
	DialogueManager.show_example_dialogue_balloon(load("res://dialogue/level_one.dialogue"), "start")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	music_begin = Game.level_one_dialogue_finished
	if music_begin and not music_started:
		music_player.play()
		music_started = true
	
