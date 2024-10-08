extends Node2D

@onready var main = get_tree().get_root().get_node("main")
@onready var arrow = load("res://Scenes/arrow.tscn")

var position_start : Vector2
var position_end : Vector2
var vector : Vector2

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
	draw_line((position_start - global_position), (position_start - global_position + vector), Color.RED, 8)
