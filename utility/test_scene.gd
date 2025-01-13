extends Node2D

var done = true
# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("TransitionHandler").transition()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if done:
		do_it()
	
func do_it():
	done = false
	await get_tree().create_timer(1.5).timeout
	get_node("TransitionHandler").transition()
	done = true
	
