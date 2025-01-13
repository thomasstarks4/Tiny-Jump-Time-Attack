extends Node2D

var is_open: bool = false
@export var scene_name: String
func _ready():
	# Ensure the door starts in the 'closed' state
	$DoorSprite.play('close')


func _on_area_2d_body_entered(body):
	# Open the door when the player enters the area
	if body.name == "Player" and not is_open:
		$DoorSprite.play('open')
		is_open = true


func _on_door_entered_area_body_entered(body):
	if body.name == "Player":
		print(scene_name)
		NavigationHandler.navigate(scene_name)

func change_scene(scene_path: String):
	get_tree().change_scene_to_file(scene_path)


func _on_door_open_area_body_exited(_body):
	if not is_open:
		pass
	else:
		is_open = false
		$DoorSprite.play('close')
