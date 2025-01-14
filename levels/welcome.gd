extends Node2D

var is_transitioning = false
func _ready():
	$TransitionHandler.fade_in()
	DialogueManager.show_example_dialogue_balloon(load("res://dialogue/welcome.dialogue"), "start")
	$Graveri.visible = false
func _process(_delta):
	$Graveri.visible = Game.show_graveri
	if Game.intro_dialogue_complete:
		if not is_transitioning:
			teleport()

func _on_audio_stream_player_2d_finished():
	$AudioStreamPlayer2D.play() #Looping music

func teleport():
	is_transitioning = true
	$TeleportSoundPlayer.play()
	var timer = get_tree().create_timer(1)
	$TransitionHandler.transition()
	await timer.timeout
	NavigationHandler.navigate("res://levels/level-one.tscn")
