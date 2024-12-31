extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$Player/Camera2D.limit_bottom = 475
	$Player/Camera2D.limit_left = -125
	$Player/Camera2D.limit_right = 907
	$Player/Camera2D.limit_top = -75 	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
