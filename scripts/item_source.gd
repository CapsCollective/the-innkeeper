extends Node

enum Item {Mead, Ale, Wine}

var icons = ["res://assets/drinkicon_blue.png", "res://assets/drinkicon_green.png", "res://assets/drinkicon_red.png"]

export (Item) var item

func get_icon_path():
	return icons[item]

func dispense():
	return item
