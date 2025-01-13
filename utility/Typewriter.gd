extends Label

@export var typewriter_speed: float = 0.07 # Speed of the typewriter effect
@export var timer_delay: float = 1.0       # Delay before restarting the typewriter effect
@export var typewriter_text: String
var full_text: String = ""                 # Full text to display
var current_index: int = 0                 # Current index of the displayed text

# Coroutine for the typewriter effect
func typewriter_effect(new_text: String) -> void:
	# Initialize variables
	full_text = new_text
	current_index = 0
	text = ""  # Clear the Label's text

	# Start the typing effect
	while current_index < full_text.length():
		current_index += 1
		text = full_text.substr(0, current_index)  # Update the visible text
		await get_tree().create_timer(typewriter_speed).timeout  # Wait before showing the next character

	# Ensure the full text is displayed at the end (optional)
	text = full_text

	# Wait for the delay before clearing the text
	await get_tree().create_timer(timer_delay).timeout

	# Clear the text and restart the typewriter effect
	text = ""  # Clear the text
	typewriter_effect(typewriter_text)

	text = full_text
func _ready():
	typewriter_effect(typewriter_text)
