extends CharacterBody2D

var SPEED : float


var shot_from : String
var direction : float
var spawnPos : Vector2
var spawnRot : float
@export var gravity : float
var hit = false
var velo : Vector2
var temp = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	global_position = spawnPos
	global_rotation = spawnRot
	
	velocity = velo
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if !hit:
		velocity.y += gravity * delta
		
		global_position += velocity * delta
		
		global_rotation = velocity.angle()
		move_and_slide()
		#print("Velocity: ", velocity)
	else:
		velocity = Vector2.ZERO
		if temp:
			$"Despawn Timer".start()
			temp = false
		$CollisionShape2D.disabled = true



func _on_despawn_timer_timeout() -> void:
	#self.queue_free()
	pass
