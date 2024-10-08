extends Area2D

signal vector_created(vector)

@export var max_length = 200

var touch_down = false
var position_start = Vector2.ZERO
var position_end = Vector2.ZERO

var vector = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pass
	
func _input(event):
	if not touch_down:
		return
	if event is InputEventMouseMotion:
		position_end = event.position
		vector = -(position_end - position_start).limit_length(max_length)
		
func _on_input_event(_viewport, event : InputEvent, _shape_idx):
	if event.is_action_pressed("Draw"):
		touch_down = true
		position_start = event.position
		queue_redraw()
		
#func _draw() -> void:
	#draw_line((position_start - global_position), (position_end - global_position), Color.BLUE, 8)
	#draw_line((position_start - global_position), (position_start - global_position + vector), Color.RED, 16)

	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_draw() -> void:
	draw_line((position_start - global_position), (position_end - global_position), Color.BLUE, 8)
	draw_line((position_start - global_position), (position_start - global_position + vector), Color.RED, 16)
	pass # Replace with function body.
