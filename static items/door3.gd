extends Node2D

var isOpen = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	$DoorSprite.play('close')

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	if body.name == 'Player':
		if !isOpen:
			$DoorSprite.play('open')
			isOpen = true
			


func _on_door_entered_area_body_entered(body):
	if body.name == 'Player':
		get_tree().change_scene_to_file("res://levels/level-one.tscn")
