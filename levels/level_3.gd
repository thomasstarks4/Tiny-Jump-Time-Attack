extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$Player/Camera2D.limit_bottom = 630
	$Player/Camera2D.limit_left = -75
	$Player/Camera2D.limit_right = 890
	$Player/Camera2D.limit_top = -60 	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
