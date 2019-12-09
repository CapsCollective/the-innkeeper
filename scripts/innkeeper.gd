extends KinematicBody2D

export (int) var max_interaction_cooldown = 100
export (int) var speed = 200
export (int) var items_limit

onready var anim_player = $AnimationPlayer
onready var interaction_range = $InteractionRange
onready var speech_bubble = $SpeechBubble
onready var preview_icon = $SpeechBubble/PreviewIcon

var items = []
var available_interactable = null
var interaction_cooldown = 0

func _physics_process(_delta):
	check_interactions()
	display_interactions()
	move()
	
	if interaction_cooldown > 0:
		interaction_cooldown -= 1

func check_interactions():
	var overlapping_areas = interaction_range.get_overlapping_areas()
	if overlapping_areas.empty():
		available_interactable = null
	else:
		var min_dist = 10000000000.0
		var closest
		for area in overlapping_areas:
			var distance = (area.global_position - position).length()
			if distance < min_dist:
				min_dist = distance
				closest = area
			available_interactable = closest

func display_interactions():
	if available_interactable and interaction_cooldown <= 0:
		speech_bubble.visible = true
		if items.size() < items_limit:
			preview_icon.texture = load(available_interactable.get_icon_path())
			if Input.is_action_pressed("interact"):
				items.append(available_interactable.dispense())
				interaction_cooldown = max_interaction_cooldown
		else:
			preview_icon.texture = preload("res://assets/X.png")
	else:
		speech_bubble.visible = false

func move():
	var velocity = Vector2()
	var play_anim
	if Input.is_action_pressed('right'):
		velocity.x += 1
		play_anim = "walk"
	if Input.is_action_pressed('left'):
		velocity.x -= 1
		play_anim = "walk"
	if Input.is_action_pressed('down'):
		velocity.y += 1
		play_anim = "walk"
	if Input.is_action_pressed('up'):
		velocity.y -= 1
		play_anim = "walk"
	velocity = velocity.normalized() * speed
	velocity = move_and_slide(velocity)
	if play_anim:
		anim_player.play(play_anim)
	else:
		anim_player.stop()
