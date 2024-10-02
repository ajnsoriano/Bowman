extends CharacterBody2D

@export var SPEED = 100

var direction : float
var spawnPos : Vector2
var spawnRot : float


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	global_position = spawnPos
	global_rotation = spawnRot


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	velocity = Vector2(0, -SPEED).rotated(direction)
	move_and_slide()
	
