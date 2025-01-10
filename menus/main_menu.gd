extends Control
@onready var music_player = $AudioStreamPlayer2D

func _ready():
	music_player.play()
func _on_start_game_button_pressed():
	if ResourceLoader.exists("res://levels/welcome.tscn"):
			get_tree().change_scene_to_file("res://levels/welcome.tscn")
	else:
		print("Error: Scene 'level-one.tscn' does not exist.")

func _on_quit_game_button_pressed():
	get_tree().quit()
