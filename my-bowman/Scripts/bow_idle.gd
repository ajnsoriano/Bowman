extends State
class_name bow_idle

@export var animated_sprite_2d : AnimatedSprite2D
@export var bow : Node2D
var first_pass = true

func Enter():
	animated_sprite_2d.play("default")
	#animated_sprite_2d.play("default_w_arrow")
	#pass 
func Update(delta: float):
	pass

func Physics_Update(delta: float):
	if (Input.is_action_just_pressed("Draw")):
		bow.position_start = bow.get_global_mouse_position()
		print("Starting Position: ", bow.position_start)
		Transitioned.emit(self, "bow_draw")
	
	
