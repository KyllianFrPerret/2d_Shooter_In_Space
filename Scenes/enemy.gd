class_name Enemy
extends Node2D

@export var speed: float = -300.0
@export var knockback_force: float = 400
@export var knockback_recovery: float = 2000

# Called when the node enters the scene tree for the first time.

var fullLife: int =10
var lifepoint: int =10
var velocity: Vector2 

func _ready() -> void:
	position.x= randf_range(-400,400)
	velocity = Vector2.DOWN * speed
	pass # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#var target_velocity:Vector2 = Vector2.DOWN * speed
	#velocity.move_toward(target_velocity, knockback_recovery * delta)
	#global_position += velocity *delta
	position.y -= speed * delta
	position.x += (cos(position.y/50) * 50 * delta) * randf_range(5,23)
	#position -= Vector2.UP.rotated(rotation) * speed * delta
	
	
	
	
func _physics_process(delta: float) -> void:
	if position.y >+1000:
		queue_free()
		
		
func getHealthRathio()->float:
	return float(lifepoint)/fullLife

func take_damage(amount: int) -> void:
	speed *= 1.3
	var scene_ressource2: Variant = load("res://Effects/hit_spark.tscn")
	var instance2: Variant = scene_ressource2.instantiate()
	instance2.scale = Vector2(10.0, 10.0)
	instance2.global_position = global_position
	get_tree().current_scene.add_child(instance2)
	lifepoint-=1
	$EnemyRed1.modulate = Color(1,getHealthRathio() ,getHealthRathio() )
	if lifepoint==0:
		var scene_ressource: Variant = load("res://Effects/explosion.tscn")
		var instance: Variant = scene_ressource.instantiate()
		instance.scale = Vector2(10.0, 10.0)
		instance.global_position = global_position
		get_tree().current_scene.add_child(instance)
		queue_free()


func _on_area_entered(area: Area2D) -> void:
	position.y -= 5
	
	if area.has_method("loose_lifePoint"):
		area.loose_lifePoint(1)
		queue_free()
