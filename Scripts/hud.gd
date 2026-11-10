extends CanvasLayer


@onready var score_label: Label = $score
@onready var game_over_screen: Control = $game_over_screen
@onready var life_container: Control = $life_container
@onready var damage_flesh: ColorRect = $DamageFlash



func showGameOver()->void:
	game_over_screen.visible=true
	var blink_tween: Tween = create_tween()
	blink_tween.tween_property($game_over_screen,"scale",Vector2(1.3,0.7),0.5)
	blink_tween.set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_OUT)
	blink_tween.tween_property($game_over_screen,"scale",Vector2(1.0,1.0),0.5)
	blink_tween.set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_OUT)
	blink_tween.play()

	
		 
func hideGameOver()->void:
	game_over_screen.visible=false
		 

func _ready() -> void:
	GameManager.score_changed.connect(on_score_changed)
	GameManager.player_life_changed.connect(on_player_life_changed)
	GameManager.game_over.connect(showGameOver)
	await get_tree().create_timer(1.0).timeout
	

func _physics_process(delta: float) -> void:
	pass

func on_score_changed(new_score: int) -> void:
	score_label.text="Score: "+str(new_score)
	jus_du_label()


func on_player_life_changed(new_life: int)->void:
	damage_flesh.color = Color(1.0,0.0,0.0,0.4)
	var flash_tween: Tween = get_tree().create_tween()
	flash_tween.tween_property(damage_flesh, "color", Color(1.0, 0.0, 0.0, 0.25),0.1)
	flash_tween.set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	flash_tween.play()
	for i: int in life_container.get_child_count():
		life_container.get_child(i).visible = i < new_life
		


func jus_du_label() -> void:
	var duration: float = 0.5
	var tween: Tween = create_tween()
	
	tween.set_parallel(true)
	tween.tween_property(score_label, "scale", Vector2(1.5, 1.5), duration).set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_OUT)
	
	var rotation_tween:Tween = create_tween()
	var timing: float = duration / 4.0
	var angle_max:float = deg_to_rad(12.0)
	rotation_tween.tween_property(score_label, "rotation", angle_max, timing).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_OUT)    
	rotation_tween.tween_property(score_label, "rotation", -angle_max, timing * 2).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_OUT)

func _on_button_pressed() -> void:
	GameManager.restart()
	hideGameOver()


func _on_button_2_pressed() -> void:
	get_tree().quit()
