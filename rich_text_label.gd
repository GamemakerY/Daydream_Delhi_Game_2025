
extends Label

@export var full_text := "Hello, this is animated text!"
@export var delay := 0.05  # Delay between letters (seconds)
var char_index := 0

func _ready():
	text = ""
	char_index = 0
	start_typing()

func start_typing():
	text = ""
	char_index = 0
	var timer = Timer.new()
	timer.wait_time = delay
	timer.one_shot = false
	timer.connect("timeout", Callable(self, "_on_timer_timeout"))
	add_child(timer)
	timer.star
func _on_timer_timeout():
	if char_index < full_text.length():
		text += full_text[char_index]
		char_index += 1
	else:
		$Timer.queue_free()  # Stop typing
