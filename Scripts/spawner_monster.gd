extends Area2D


@export var enemy_scene: PackedScene
@export var time_between_shots: float = 0.08
var cooldown: float = 0.0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	cooldown += delta
	if cooldown> time_between_shots:
		var bullet: Enemy = enemy_scene.instantiate()
		bullet.global_position = global_position
		get_tree().current_scene.add_child(bullet)
		cooldown=0.0
