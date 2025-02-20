extends Node2D

@onready var parallax_background: ParallaxBackground = $ParallaxBackground

var scroll = false
var SCROLL_SPEED : float #px / second
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if scroll:
		parallax_background.scroll_offset.x -= delta * SCROLL_SPEED
	
