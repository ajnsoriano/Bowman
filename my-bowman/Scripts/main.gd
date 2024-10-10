extends Node2D

@onready var player_1: Node2D = $Player1
@onready var cpu: Node2D = $CPU
@onready var cpu_bow_sprite: AnimatedSprite2D = $"CPU/CPU Bow Sprite"
@onready var player_bow_sprite_2d: AnimatedSprite2D = $Player1/bow/AnimatedSprite2D

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
	player_1.current_turn = false
	current_player = cpu
	activate_cpu.emit()


func _on_cpu_end_turn() -> void:
	var tween = create_tween()
	tween.tween_property($Camera2D, 'position', player_bow_sprite_2d.global_position, 1.5).set_trans(Tween.TRANS_EXPO)
	cpu.current_turn = false
	current_player = player_1
