extends Area2D


	
@export var speed: float = 800.0
@export var x_limit: float = 320.0
@export var max_tilt_degrees: float = 20.0
@export var acceleration: float = 8000.0

@export var invincibility_time: float = 1.0
var is_invicible: bool = false


@export var bullet_scene: PackedScene

var velocity: Vector2 = Vector2.ZERO
var velocityY: Vector2 = Vector2.ZERO

var life: int = 5

func on_invicible_end()-> void:
	is_invicible = false



func _ready() -> void:
	$invincibility_timer.timeout.connect(on_invicible_end)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	var target_velocity: Vector2 = read_direction() * speed
	velocity = velocity.move_toward(target_velocity, acceleration * delta)
	position += velocity * delta
	position.x = clamp(position.x,-x_limit,x_limit)
	
	var target_velocityY: Vector2 = read_Ydirection() * speed
	velocityY = velocityY.move_toward(target_velocityY, acceleration * delta)
	position += velocityY * delta
	#position.Y = clamp(position.x,-x_limit,x_limit)
	
	$sprite.rotation = deg_to_rad(max_tilt_degrees) * velocity.x / speed
	
	
func read_direction() -> Vector2:
	var direction: Vector2 = Vector2.ZERO
	direction.x = Input.get_axis("move_left","move_right")
		
	if Input.is_action_pressed("touch"):
		var xDestination: float = get_global_mouse_position().x
		var distance_to_finger: float = xDestination - position.x
		direction.x = clamp(distance_to_finger / 60, -1, 1)
	return direction
	
	
	
func read_Ydirection() -> Vector2:
	var direction: Vector2 = Vector2.ZERO
	direction.y = Input.get_axis("move_up","move_down")
		
	if Input.is_action_pressed("touch"):
		var yDestination: float = get_global_mouse_position().y
		var distance_to_finger: float = yDestination - position.y
		direction.y = clamp(distance_to_finger / 60, -1, 1)
	return direction
	
func loose_lifePoint(dégat: int)-> void:
	if is_invicible:
		return
	is_invicible= true
	$invincibility_timer.start()
	var blink_tween: Tween = get_tree().create_tween()
	blink_tween.tween_property($sprite, "modulate:a",0.4,0.25)
	blink_tween.tween_property($sprite, "modulate:a",1.0,0.25)
	blink_tween.play()
	life -=1
	$AudioStreamPlayer2D.play()
	GameManager.take_damage(life)
	if life==0:
		var scene_ressource: Variant = load("res://Effects/explosion.tscn")
		var instance: Variant = scene_ressource.instantiate()
		instance.global_position = global_position
		get_tree().current_scene.add_child(instance)
		
		queue_free()
		GameManager.trigger_game_over()
