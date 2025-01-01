extends Node2D

@onready var music_player = $AudioStreamPlayer2D
# Called when the node enters the scene tree for the first time.
func _ready():
	$Player/Camera2D.limit_bottom = 280
	$Player/Camera2D.limit_left = 0
	$Player/Camera2D.limit_right = 525
	$Player/Camera2D.limit_top = -226 	
	music_player.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
