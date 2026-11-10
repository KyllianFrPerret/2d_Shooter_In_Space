extends Camera2D

@export var offset_max: float = 30.0
@export var decay: float = 1.5


var trauma: float = 0.0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.player_life_changed.connect(on_player_life_changed)


func add_trauma(val: float)-> void:
	trauma+=val
	trauma= clamp(trauma,0.0, 1.0)
	

func _process(delta: float) -> void:
	var shake_value: float=pow(trauma,2)
	var rand_offset_dir: Vector2= Vector2(randf_range(-1,1), randf_range(-1,1))
	offset = rand_offset_dir * shake_value * offset_max
	
	trauma = max(trauma -( decay * delta),0.0)
	
func on_player_life_changed(new_life: int)->void:
	add_trauma(3.6)
	if new_life <=0:
		add_trauma(3.0)



# Called every frame. 'delta' is the elapsed time since the previous frame.
