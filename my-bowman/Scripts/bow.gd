extends Node2D

@onready var main = get_tree().get_root().get_node("main")
@onready var arrow = load("res://Scenes/arrow.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#shoot()
	pass

func shoot():
	var instance = arrow.instantiate()
	instance.direction = rotation
	instance.spawnPos = global_position
	instance.spawnRot = rotation
	main.add_child.call_deferred(instance)
	
func _physics_process(delta: float) -> void:
	rotation_degrees += 50 * delta
	
	


func _on_timer_timeout() -> void:
	shoot()
