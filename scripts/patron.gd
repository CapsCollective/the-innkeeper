extends KinematicBody2D

var has_drink = false
var drink_type = 0
var drink_time = 200

func _physics_process(_delta):
	if not has_drink:
		$SpeechBubble.visible = true
		$SpeechBubble/PreviewIcon.texture = preload("res://assets/drinkicon_blue.png")
	else:
		$SpeechBubble.visible = false
		drink_time -= 1
	
	if drink_time <= 0:
		drink_time = 200
		has_drink = false

func get_icon_path():
	return "res://assets/drinkicon_blue.png"

func is_interactable(player):
	return not has_drink and player.items.has(drink_type)

func interact(player):
	player.remove_drink(drink_type)
	has_drink = true
