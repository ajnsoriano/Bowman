extends Camera2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	global_position = $"../Player1".global_position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass