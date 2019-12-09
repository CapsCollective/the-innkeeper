extends Node

enum Item {Mead, Ale, Wine}

var icons = ["res://assets/drinkicon_blue.png", "res://assets/drinkicon_green.png", "res://assets/drinkicon_red.png"]

export (Item) var item

onready var bar = get_parent()

func is_interactable(player):
	return player.items.size() < player.items_limit and bar.cups_available > 0


func interact(player):
	player.items.append(item)
	bar.cups_available -= 1

func get_icon_path():
	return icons[item]

