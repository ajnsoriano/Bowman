extends State

@onready var player_1: Node2D = $"../../Player1"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player_1.current_turn = true

func _on_bow_shoot_end_turn() -> void:
	player_1.current_turn = false
	Transitioned.emit(self, "CPU Turn")
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func Enter():
	print("PLAYER TURN")
	player_1.current_turn = true
	pass
	
func Exit():
	pass
	
func Update(_delta: float):
	pass

func Physics_Update(_delta: float):
	pass
