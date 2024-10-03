extends State
class_name bow_draw

@onready var animated_sprite_2d: AnimatedSprite2D = $"../../AnimatedSprite2D"
var fully_drawn = false

func Enter():
	animated_sprite_2d.play('draw')
	$"Draw Timer".start()
	pass 
	
func Update(delta: float):
	pass

func Physics_Update(delta: float):
	if Input.is_action_just_released("Draw"):
		if fully_drawn:
			print("SHOOT")
			Transitioned.emit(self, "bow_shoot")
			fully_drawn = false

		else:
			Transitioned.emit(self, "bow_idle")
			$"Draw Timer".stop()

func _on_draw_timer_timeout() -> void:
	fully_drawn = true
	pass # Replace with function body.
