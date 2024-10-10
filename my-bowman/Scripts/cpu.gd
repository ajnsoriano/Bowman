extends Node2D

var current_turn = false

signal end_turn

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
		


func _on_temp_delay_timer_timeout() -> void:
	print("CPU TURN END")
	end_turn.emit()


func _on_main_activate_cpu() -> void:
	$"Temp delay timer".start()
