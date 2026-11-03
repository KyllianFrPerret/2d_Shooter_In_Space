class_name Bullet
extends Node2D

@export var speed: float = 1000.0
@export_range(0, PI/2, PI/180) var rotation_range: float = 3 * PI /100




# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rotation = randf_range(-rotation_range, rotation_range)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.y -= speed * delta
	position += Vector2.UP.rotated(rotation) * speed * delta
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if position.y <-1000:
		queue_free()




func _on_area_entered(area: Area2D) -> void:
	if area.has_method("take_damage"):
		area.take_damage(1)
		queue_free()
		
