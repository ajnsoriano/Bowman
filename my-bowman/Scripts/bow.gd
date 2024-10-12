extends Node2D

var position_start : Vector2
var position_end : Vector2
var vector : Vector2
var shooting = false
@export var max_length : float = 200
@export var background : Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#shoot()
	pass
	
func _physics_process(delta: float) -> void:	
	background.SCROLL_SPEED = vector.length()
	queue_redraw()
	pass

func _draw() -> void:
	draw_line((position_start - global_position), (position_end - global_position), Color.BLUE, 4)
	draw_line((position_start - global_position), (position_start - global_position + (vector / 10)), Color.RED, 8)
