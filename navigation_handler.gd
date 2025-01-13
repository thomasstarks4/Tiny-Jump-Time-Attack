extends Node

func navigate(scene_name):
	if scene_name == null:
		print("Scene does not exist")
		print(str(scene_name))
	else:
		print(scene_name)
		get_tree().change_scene_to_file(scene_name)
