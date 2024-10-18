extends State
class_name bow_draw

@onready var animated_sprite_2d: AnimatedSprite2D = $"../../AnimatedSprite2D"
@export var left_arm : AnimatedSprite2D
@export var right_arm : AnimatedSprite2D
@export var bow : Node2D

func Enter():
	$"../../../../Draw Bow".playing = true
	animated_sprite_2d.play('draw')
	right_arm.play('draw')
	$"Draw Timer".start()
	pass 
	
func Update(delta: float):
	pass

func Physics_Update(delta: float):
	
	#calculate aim vector
	if InputEventMouseMotion:
		bow.position_end = bow.get_global_mouse_position() 
		bow.vector = -((bow.position_end - bow.position_start) * 4).limit_length(bow.max_length)
		animated_sprite_2d.look_at(bow.global_position + bow.vector)
		left_arm.look_at(bow.global_position + bow.vector)
		right_arm.look_at(bow.global_position + bow.vector)
	if Input.is_action_just_released("Draw"):
		#print("SHOOT")
		Transitioned.emit(self, "bow_shoot")

				
