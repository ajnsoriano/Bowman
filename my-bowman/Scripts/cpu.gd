extends Node2D
@export var g : float
@export var health : int = 3
@onready var main = get_tree().get_root().get_node("main")
@onready var arrow = load("res://Scenes/arrow.tscn")
@onready var player_body: AnimatedSprite2D = $"../Player1/Body"
@onready var camera_2d: Camera2D = $"../Camera2D"
@export var min_speed : float
@export var max_speed : float
@export var Random_Range : float
var current_turn = false
var shooting = false
var max_iterations = 100
var aiming = false
var speed
var angle
signal end_turn

var instance
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if shooting:
		camera_2d.global_position = instance.global_position
			
func calculate_speed_and_angle(target_pos: Vector2, start_pos: Vector2) -> Dictionary:
	var distance = target_pos.x - start_pos.x  # Horizontal distance to the target
	var height_diff = target_pos.y - start_pos.y  # Vertical distance to the target (can be negative if target is lower)

	for i in range(max_iterations):
		var speed = lerp(min_speed, max_speed, float(i) / max_iterations)  # Vary speed from min to max
		
		# Use the projectile equation to compute two possible angles for this speed
		var result = find_launch_angles(speed, distance, height_diff)
		if result != null:
			return {"speed": speed, "angle": result}  # Return the speed and one valid angle
	
	# Return a default value if no valid solution is found
	return {"speed": min_speed, "angle": 0}

# Function to find possible angles for a given speed, distance, and height difference
func find_launch_angles(speed: float, distance: float, height_diff: float):
	#var g = 
	var speed_squared = pow(speed, 2)
	
	# Calculate the discriminant for the angle equation
	var discriminant = speed_squared * speed_squared - g * (g * pow(distance, 2) + 2 * height_diff * speed_squared)
	
	if discriminant < 0:
		return null  # No valid solution if discriminant is negative
	
	# Calculate the two possible launch angles
	var angle1 = atan((speed_squared + sqrt(discriminant)) / (g * distance))
	var angle2 = atan((speed_squared - sqrt(discriminant)) / (g * distance))
	
	# Choose the lower angle (or fall back to higher if invalid)
	return angle2 if angle2 >= 0 else angle1
	

func shoot_at_player():
	var target_pos = player_body.global_position
	var start_pos = $"CPU Bow Sprite/Marker2D".global_position
	var result = calculate_speed_and_angle(target_pos, start_pos)
	
	if result != null:
		speed = result["speed"]
		angle = result["angle"]
		
		angle = add_random_angle(angle)
		speed = add_random_speed(speed)
		
		var vx = speed * cos(angle) # horizontal
		var vy = -speed * sin(angle) # Vertical
	
		instance = arrow.instantiate()
		instance.shot_from = "CPU"
		instance.spawnPos = start_pos
		instance.global_rotation = angle
		instance.velo = -Vector2(vx, vy)
		
		$"Aim Delay timer".start()
		
		$"CPU Bow Sprite".play("draw")
		$"Right Arm".play("draw")
		
		var tween = create_tween()
		tween.tween_property($"CPU Bow Sprite", 'rotation', angle + PI / 2, 2)
		tween.parallel().tween_property($"Right Arm", 'rotation', angle + PI / 2, 2)
		tween.parallel().tween_property($"Left Arm", 'rotation', angle + PI / 2, 2)

func add_random_angle(angle):
	var result = angle + deg_to_rad(randf_range(-Random_Range, Random_Range))
	return result
		
func add_random_speed(speed):
	var result = speed + randi_range(-Random_Range, Random_Range )
	return result
	
func _on_main_activate_cpu() -> void:
	shoot_at_player()


func _on_cpu_camera_delay_timeout() -> void:
	end_turn.emit()


func _on_aim_delay_timer_timeout() -> void:
	main.add_child.call_deferred(instance)
	
	$"CPU Bow Sprite".play('default')
	$"Right Arm".play('default')
	
	var tween = create_tween()
	tween.tween_property($"CPU Bow Sprite", 'rotation', 0, 1).set_trans(Tween.TRANS_ELASTIC)
	tween.parallel().tween_property($"Right Arm", 'rotation', 0, 1).set_trans(Tween.TRANS_ELASTIC)
	tween.parallel().tween_property($"Left Arm", 'rotation', 0, 1).set_trans(Tween.TRANS_ELASTIC)
	print("CPU arrow:")
	print("Speed: ", speed)
	print("Angle: ", rad_to_deg(angle))
	print("Velocity: ", instance.velo)
	
	shooting = true
