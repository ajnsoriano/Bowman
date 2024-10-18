extends Node2D

@onready var player_1: Node2D = $Player1
@onready var cpu: Node2D = $CPU
@onready var cpu_bow_sprite: AnimatedSprite2D = $"CPU/CPU Bow Sprite"
@onready var player_bow_sprite_2d: AnimatedSprite2D = $Player1/bow/AnimatedSprite2D
@onready var bow: Node2D = $Player1/bow
@onready var mountain_field: Node2D = $"Mountain Field"
@onready var button: Button = $Camera2D/Button
@onready var rich_text_label: RichTextLabel = $Camera2D/RichTextLabel
@export var CPU_Debug = false
var current_player

signal activate_cpu

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if !CPU_Debug:
		cpu.global_position = Vector2(randi_range(3000, 5000), 695)
	current_player = player_1
	player_1.current_turn = true
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	current_player.current_turn = true

func _physics_process(delta: float) -> void:
	pass
	
func end_game(result):
	if result == "win":
		$Camera2D/Win.visible = true
	else:
		$Camera2D/Lose.visible = true
	button.disabled = false
	button.visible = true
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
	await  tween.finished
	current_player = player_1
	cpu.current_turn = false
	

func _on_ground_body_entered(body: Node2D) -> void:
	$"Arrow Hit Ground".playing = true
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
	$"Arrow Hit".playing = true
	body.hit = true 
	body.z_index = -1
	mountain_field.scroll = false
	bow.shooting = false
	cpu.health = 0
	body.get_node("Blood").emitting = true
	await body.get_node("Blood").finished
	if cpu.health <= 0:
		end_game("win")
	else:
		$"Player Camera Delay".start()


func _on_CPU_torso_body_entered(body: Node2D) -> void:
	$"Arrow Hit".playing = true
	body.hit = true 
	body.z_index = -1
	mountain_field.scroll = false
	bow.shooting = false
	cpu.health -= 2
	body.get_node("Blood").emitting = true
	await body.get_node("Blood").finished
	if cpu.health <= 0:
		end_game("win")
	else:
		$"Player Camera Delay".start()

func _on_CPU_legs_body_entered(body):
	$"Arrow Hit".playing = true
	body.hit = true
	body.z_index = -1
	mountain_field.scroll = false
	bow.shooting = false
	cpu.health -= 1
	body.get_node("Blood").emitting = true
	await body.get_node("Blood").finished
	if cpu.health <= 0:
		end_game("win")
	else:
		$"Player Camera Delay".start()


func _on_player_head_body_entered(body):
	$"Arrow Hit".playing = true
	body.hit = true 
	body.z_index = -1
	mountain_field.scroll = false
	cpu.shooting = false
	player_1.health = 0
	body.get_node("Blood").emitting = true
	await body.get_node("Blood").finished
	if player_1.health <= 0:
		end_game("lose")
	else:
		$"CPU Camera Delay".start()


func _on_player_torso_body_entered(body):
	$"Arrow Hit".playing = true
	body.hit = true 
	body.z_index = -1
	mountain_field.scroll = false
	cpu.shooting = false
	player_1.health -= 2
	body.get_node("Blood").emitting = true
	await body.get_node("Blood").finished
	if player_1.health <= 0:
		end_game("lose")
	else:
		$"CPU Camera Delay".start()


func _on_player_legs_body_entered(body):
	$"Arrow Hit".playing = true
	body.hit = true 
	body.z_index = -1
	mountain_field.scroll = false
	cpu.shooting = false
	player_1.health -= 1
	body.get_node("Blood").emitting = true
	await body.get_node("Blood").finished
	if player_1.health <= 0:
		end_game("lose")
	else:
		$"CPU Camera Delay".start()


func _on_button_pressed() -> void:
	get_tree().reload_current_scene()


func _on_quit_pressed() -> void:
	self.get_tree().quit()
