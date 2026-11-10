extends Node

var score: int

var hit_stop_timer: SceneTreeTimer = null

signal score_changed(score: int)
signal player_life_changed(life: int)
signal game_over()




func take_damage(point: int)->void:
	player_life_changed.emit(point)

func add_score(point: int) -> void:
	score+=point
	score_changed.emit(score)
	
func trigger_game_over() -> void:
	get_tree().paused = true
	game_over.emit()

func restart() -> void:
	score=0
	get_tree().paused = false
	get_tree().reload_current_scene.call_deferred()
	


func hit_stope(duration: float)-> void:
	Engine.time_scale = 0.5
	#if hit_stop_timer:
		#hit_stop_timer.stop()
	hit_stop_timer= get_tree().create_timer(duration, true, false, true)
	hit_stop_timer.timeout.connect(on_hitstop_end)

func on_hitstop_end()->void:
	Engine.time_scale=1.0
	hit_stop_timer=null
	


func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
