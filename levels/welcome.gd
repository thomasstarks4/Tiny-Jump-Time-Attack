extends Node2D

func _ready():
	$TransitionHandler.fade_in()
	DialogueManager.show_example_dialogue_balloon(load("res://dialogue/welcome.dialogue"), "start")
	$Graveri.visible = false
func _process(_delta):
	$Graveri.visible = Game.show_graveri
	if Game.intro_dialogue_complete:
		$TransitionHandler.transition()
		#await $TransitionHandler/TransitionPlayer.animation_finished
		NavigationHandler.navigate("res://levels/level-one.tscn")


func _on_audio_stream_player_2d_finished():
	$AudioStreamPlayer2D.play() #Looping music
