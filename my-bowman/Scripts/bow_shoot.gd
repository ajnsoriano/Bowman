extends State
class_name bow_shoot
@onready var main = get_tree().get_root().get_node("main")
@onready var arrow = load("res://Scenes/arrow.tscn")
@onready var animated_sprite_2d: AnimatedSprite2D = $"../../AnimatedSprite2D"
@export var right_arm : AnimatedSprite2D
@export var camera : Camera2D
@export var bow : Node2D
@export var background : Node2D
@onready var cpu_bow_sprite: AnimatedSprite2D = $"../../../../CPU/CPU Bow Sprite"


var instance

signal end_turn
	
func Enter():
	animated_sprite_2d.play("default")
	right_arm.play("default")
	shoot()
	bow.shooting = true
	background.scroll = true
	
func Update(delta: float):
	pass
	
func Physics_Update(delta: float):
	if bow.shooting:
		camera.global_position = instance.global_position
	pass	

func shoot():
	instance = arrow.instantiate()
	instance.direction = bow.rotation
	instance.spawnPos = bow.global_position
	instance.spawnRot = bow.rotation
	instance.velo =  bow.vector
	instance.shot_from = "P1"
	
	main.add_child.call_deferred(instance)
	
	print("P1 arrow:")
	print("Direction: ", instance.direction)
	print("Rotation: ", instance.global_rotation)
	print("Angle: ", rad_to_deg(instance.velo.angle()))
	print("Velocity: ", instance.velo)
	
func _on_player_camera_delay_timeout() -> void:
	end_turn.emit()
	Transitioned.emit(self, "bow_idle")
