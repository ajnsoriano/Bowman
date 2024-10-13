extends Node2D

@onready var player_1: Node2D = $Player1
@onready var cpu: Node2D = $CPU
@onready var cpu_bow_sprite: AnimatedSprite2D = $"CPU/CPU Bow Sprite"
@onready var player_bow_sprite_2d: AnimatedSprite2D = $Player1/bow/AnimatedSprite2D
@onready var bow: Node2D = $Player1/bow
@onready var mountain_field: Node2D = $"Mountain Field"

var current_player

signal activate_cpu

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	current_player = player_1
	player_1.current_turn = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	current_player.current_turn = true

func _physics_process(delta: float) -> void:
	pass


func _on_player_end_turn() -> void:
	var tween = create_tween()
	tween.tween_property($Camera2D, 'position', cpu_bow_sprite.global_position, 1.5).set_trans(Tween.TRANS_EXPO)
	current_player = cpu
	player_1.current_turn = false
	activate_cpu.emit()


func _on_cpu_end_turn() -> void:
	var tween = create_tween()
	tween.tween_property($Camera2D, 'position', player_bow_sprite_2d.global_position, 1.5).set_trans(Tween.TRANS_EXPO)
	current_player = player_1
	cpu.current_turn = false
	

func _on_ground_body_entered(body: Node2D) -> void:
	body.hit = true
	mountain_field.scroll = false
	if body.shot_from == "P1":
		bow.shooting = false
		$"Player Camera Delay".start()
	elif body.shot_from == "CPU":
		cpu.shooting = false
		cpu_bow_sprite.play("default_w_arrow")
		$"CPU Camera Delay".start()
	


func _on_CPU_head_body_entered(body: Node2D) -> void:
	body.hit = true 
	body.z_index = -1
	mountain_field.scroll = false
	bow.shooting = false
	cpu.health -= 3
	
	$"Player Camera Delay".start()


func _on_CPU_torso_body_entered(body: Node2D) -> void:
	body.hit = true 
	body.z_index = -1
	mountain_field.scroll = false
	bow.shooting = false
	cpu.health -= 2
	
	$"Player Camera Delay".start()


# Replace with function body.


func _on_CPU_legs_body_entered(body):
	body.hit = true
	body.z_index = -1
	mountain_field.scroll = false
	bow.shooting = false
	cpu.health -= 1

	$"Player Camera Delay".start()


func _on_player_head_body_entered(body):
	body.hit = true 
	body.z_index = -1
	mountain_field.scroll = false
	cpu.shooting = false
	player_1.health -= 3

	$"CPU Camera Delay".start()


func _on_player_torso_body_entered(body):
	body.hit = true 
	body.z_index = -1
	mountain_field.scroll = false
	cpu.shooting = false
	player_1.health -= 2

	$"CPU Camera Delay".start()


func _on_player_legs_body_entered(body):
	body.hit = true 
	body.z_index = -1
	mountain_field.scroll = false
	cpu.shooting = false
	player_1.health -= 1

	$"CPU Camera Delay".start()
