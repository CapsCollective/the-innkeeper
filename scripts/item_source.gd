extends Node

enum Item {Mead, Ale, Wine, Soup}

export (Item) var item

func dispense():
	return item
