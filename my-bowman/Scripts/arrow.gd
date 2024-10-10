extends CharacterBody2D

@export var SPEED : float



var direction : float
var spawnPos : Vector2
var spawnRot : float
@export var gravity : float = 9.8
var hit = false
var velo : Vector2
var temp = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	global_position = spawnPos
	global_rotation = spawnRot
	
	#velocity = Vector2(cos(spawnRot), sin(spawnRot)) * SPEED
	velocity = velo * SPEED

	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if !hit:
		velocity.y += gravity * delta
		
		global_position += velocity * delta
		
		global_rotation = velocity.angle()
		move_and_slide()
	else:
		if temp:
			$"Despawn Timer".start()
			temp = false
		$CollisionShape2D.disabled = true



func _on_despawn_timer_timeout() -> void:
	#self.queue_free()
	pass
