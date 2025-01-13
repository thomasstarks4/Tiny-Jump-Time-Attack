extends CanvasLayer

@onready var rect = $TransitionRect
@onready var anim = $TransitionPlayer

signal transition_finished
# Called when the node enters the scene tree for the first time.
func _ready():
	rect.visible = false
	anim.animation_finished.connect(_on_animation_finished)
	
func transition():
	rect.visible = true
	anim.play("scene_fade_out")
	transition_finished.emit()

func _on_animation_finished(anim_name):
	if anim_name == "scene_fade_in":
		rect.visible = false
	elif anim_name == "scene_fade_out":
		pass

func fade_in():
	rect.visible = true
	anim.play("scene_fade_in")
	await anim.animation_finished
	rect.visible = false
