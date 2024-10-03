extends State
class_name bow_shoot

@onready var main = get_tree().get_root().get_node("main")
@onready var arrow = load("res://Scenes/arrow.tscn")

@export var bow : Node2D

func Enter():
	shoot()
	
func Update(delta: float):
	Transitioned.emit(self, "bow_idle")

func Physics_Update(delta: float):
	pass	

func shoot():
	var instance = arrow.instantiate()
	instance.direction = bow.rotation
	instance.spawnPos = bow.global_position
	instance.spawnRot = bow.rotation
	main.add_child.call_deferred(instance)
