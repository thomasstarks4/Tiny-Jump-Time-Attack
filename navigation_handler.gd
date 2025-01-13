extends Node

func navigate(scene_name):
	if scene_name == null:
		print("Scene does not exist")
		print(str(scene_name))
	else:
		Game.player_stopped = true
		var current_scene = get_tree().current_scene
		var transition_handler = current_scene.get_node("TransitionHandler")
		var transition_animation = transition_handler.get_node("TransitionPlayer")
		if transition_handler == null:
			print("TransitionHandler is null. Changing scenes.")
			get_tree().change_scene_to_file(scene_name)
		else:
			transition_handler.transition()
			await transition_animation.animation_finished
			get_tree().change_scene_to_file(scene_name)
