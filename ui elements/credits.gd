extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$CreditsMusicPlayer.play()
	$Label.text = "











Thanks For Playing!!!














Special thanks to the following folks! Without you, none of this would have been possible!!!








Music By:

Piano loops 175 efect 2 octave long loop 120 bpm by josefpres -- https://freesound.org/s/784590/ -- License: Creative Commons 0

Sound Effects By:

Item or Material Pickup Pop 1 of 3 by el_boss -- https://freesound.org/s/665183/ -- License: Creative Commons 0

Item or Material Pickup Pop 2 of 3 by el_boss -- https://freesound.org/s/665182/ -- License: Creative Commons 0

Item or Material Pickup Pop 3 of 3 by el_boss -- https://freesound.org/s/665181/ -- License: Creative Commons 0"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Label.position.y -= delta * 25
