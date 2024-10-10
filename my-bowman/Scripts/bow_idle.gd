extends State
class_name bow_idle

@onready var main = get_tree().get_root().get_node("main")
@export var animated_sprite_2d : AnimatedSprite2D
@export var bow : Node2D
@onready var player_1: Node2D = $"../../.."

func Enter():
	animated_sprite_2d.play("default_w_arrow")

func Update(delta: float):
	pass

func Physics_Update(delta: float):
	if player_1.current_turn:
		if (Input.is_action_just_pressed("Draw")):
			bow.position_start = bow.get_global_mouse_position()
			#print("Starting Position: ", bow.position_start)
			Transitioned.emit(self, "bow_draw")
