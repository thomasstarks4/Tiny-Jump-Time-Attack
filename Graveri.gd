extends AnimatedSprite2D

@onready var anim = $AnimationPlayer
@onready var attack_timer = $Timer
# Called when the node enters the scene tree for the first time.
func _ready():
	play("idle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Game.graveri_attacked == false:
		play("attack")
	else:
		play("idle")

