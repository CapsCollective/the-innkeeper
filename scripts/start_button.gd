extends Button

func _ready():
	connect("pressed", self, "_start_game")

func _physics_process(delta):
	if Input.is_action_pressed("enter"):
		_start_game()

func _start_game():
	get_tree().change_scene("res://scenes/main.tscn")