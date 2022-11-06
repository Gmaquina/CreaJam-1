extends Control


func _ready():
	$"GameOver_Control".hide()
	self.set_process(false)

func _on_score_changed(newScore):
	$"Score_Label".text = str("Score : ", newScore)

func _on_gameover():
	$"GameOver_Control".show()
	self.set_process(true)
	Engine.time_scale = 0.1 #TODO ? in game manager?
	$"/root/LVL/Player".set_process(false) #TODO ? in game manager ?

func _process(_delta):
	if Input.is_action_just_pressed("ui_accept"):
		Engine.time_scale = 1.0 #TODO ? in game manager?
		get_tree().reload_current_scene()
