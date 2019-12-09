extends Node

onready var bar = get_parent()

func is_interactable(player):
	return not player.items.empty()

func interact(player):
	bar.move_cups(-player.items.size())
	player.clear_drinks()
	
func get_icon_path():
	return "res://assets/drinkicon_blue.png"
