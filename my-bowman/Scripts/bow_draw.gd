extends State
class_name bow_draw

@onready var main = get_tree().get_root().get_node("main")
@onready var arrow = load("res://Scenes/arrow.tscn")

@onready var animated_sprite_2d: AnimatedSprite2D = $"../../AnimatedSprite2D"


@export var bow : Node2D
#@export var max_length = 200
var fully_drawn = false


#var position_end = Vector2.ZERO


func Enter():
	animated_sprite_2d.play('draw')
	$"Draw Timer".start()
	pass 
	
func Update(delta: float):
	pass

func Physics_Update(delta: float):
	
	if InputEventMouseMotion:
		bow.position_end = bow.get_global_mouse_position() 
		bow.vector = -(bow.position_end - bow.position_start).limit_length(bow.max_length)
		animated_sprite_2d.look_at(bow.global_position + bow.vector)
		print(bow.position_end)
		
		
		
	if Input.is_action_just_released("Draw"):
		#if fully_drawn:
		print("SHOOT")
		Transitioned.emit(self, "bow_shoot")
		#fully_drawn = false

		#else:
			#Transitioned.emit(self, "bow_idle")
			#$"Draw Timer".stop()
					
func _on_draw_timer_timeout() -> void:
	fully_drawn = true
	pass # Replace with function body.
