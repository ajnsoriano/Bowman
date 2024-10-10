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
	instance.direction = bow.rotation + PI / 2
	instance.spawnPos = bow.global_position
	instance.spawnRot = bow.rotation
	instance.velo =  bow.vector
	main.add_child.call_deferred(instance)
	
func _on_ground_body_entered(body: Node2D) -> void:
	body.hit = true
	background.scroll = false
	bow.shooting = false
	$"Camera Delay".start()
	


func _on_camera_delay_timeout() -> void:
	#var tween = create_tween()
	#tween.tween_property(camera, 'position', cpu_bow_sprite.global_position, 1.5).set_trans(Tween.TRANS_EXPO)
	end_turn.emit()
	Transitioned.emit(self, "bow_idle")
	
