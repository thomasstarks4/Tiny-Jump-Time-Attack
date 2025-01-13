extends Node2D

@onready var music_player = $AudioStreamPlayer2D
# Called when the node enters the scene tree for the first time.
func _ready():
	$TransitionHandler.fade_in()
	$Player/Camera2D.limit_bottom = 475
	$Player/Camera2D.limit_left = -125
	$Player/Camera2D.limit_right = 907
	$Player/Camera2D.limit_top = -75 
	music_player.play()

