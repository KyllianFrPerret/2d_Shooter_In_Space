extends Node2D


@export var bullet_scene: PackedScene
@export var time_between_shots: float = 0.09

@onready var audio_player: AudioStreamPlayer = $AudioStreamPlayer


var cooldown: float = 0.0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	cooldown += delta
	if cooldown> time_between_shots:
		bigShot()
		cooldown=0.0



func bigShot() -> void:
	$AudioStreamPlayer2D.pitch_scale = randf_range(0.5,3.0)
	$AudioStreamPlayer2D.play()
	var bullet: Bullet = bullet_scene.instantiate()
	bullet.global_position = global_position
	get_tree().current_scene.add_child(bullet)
