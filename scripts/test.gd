extends Node2D

enum Item {Mead, Ale, Wine, Soup}

# Misc fields
var velocity = Vector2()
onready var anim_player = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(_delta):
	move()
	play_animation()

func move():
	pass

func play_animation():
	var play_anim
	if velocity.x != 0 and velocity.y != 0:
		if velocity.y > 0 and velocity.x < 0:
			play_anim = "walk_down_left"
		if velocity.y > 0 and velocity.x > 0:
			play_anim = "walk_down_right"
		if velocity.y < 0 and velocity.x < 0:
			play_anim = "walk_up_left"
		if velocity.y < 0 and velocity.x > 0:
			play_anim = "walk_up_right"
	elif velocity.x == 0 and velocity.y == 0:
		play_anim = "rest"
	else:
		if velocity.x < 0:
			play_anim = "walk_left"
		if velocity.x > 0:
			play_anim = "walk_right"
		if velocity.y > 0:
			play_anim = "walk_down"
		if velocity.y < 0:
			play_anim = "walk_up"
	anim_player.play(play_anim)