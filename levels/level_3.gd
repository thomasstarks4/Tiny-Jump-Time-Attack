extends Node2D

@onready var music_player = $AudioStreamPlayer2D
# Called when the node enters the scene tree for the first time.
func _ready():
	$TransitionHandler.fade_in()
	$Player/Camera2D.limit_bottom = 630
	$Player/Camera2D.limit_left = -75
	$Player/Camera2D.limit_right = 890
	$Player/Camera2D.limit_top = -60 	
	music_player.play()
