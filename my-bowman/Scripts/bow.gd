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
	#$AnimatedSprite2D.play("default")
	
	
func _physics_process(delta: float) -> void:
	#if (Input.is_action_just_pressed("Draw")):
		#$"Draw Timer".start()
		#$AnimatedSprite2D.play('draw')
	#else:
		#$AnimatedSprite2D.play("default")
	pass
	
