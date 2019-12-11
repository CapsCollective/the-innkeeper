extends KinematicBody2D

export (int) var max_interaction_cooldown = 100
export (int) var speed = 200
export (int) var items_limit = 3

var drink_icons = ["res://assets/drinkicon_blue.png", "res://assets/drinkicon_green.png", "res://assets/drinkicon_red.png"]
export (Array) var drink_sprites

onready var anim_player = $AnimationPlayer
onready var interaction_range = $InteractionRange
onready var speech_bubble = $SpeechBubble
onready var preview_icon = $SpeechBubble/PreviewIcon

var items = []
var interaction_cooldown = 0
var previous_bubble_open = false
var bubble_open = false

func _physics_process(_delta):
	check_interactions()
	move()
	
	if interaction_cooldown > 0:
		interaction_cooldown -= 1

func check_interactions():
	var objects = interaction_range.get_overlapping_areas()
	objects = objects + interaction_range.get_overlapping_bodies()
	var overlapping_areas = []
	for i in range(objects.size()):
		if objects[i].is_in_group("interactable"):
			overlapping_areas.append(objects[i])
	if overlapping_areas.empty():
		speech_bubble.visible = false
		bubble_open = false
		return
	var min_dist = 10000000000.0
	var closest
	for area in overlapping_areas:
		var distance = (area.global_position - position).length()
		if distance < min_dist:
			min_dist = distance
			closest = area

	speech_bubble.visible = true
	bubble_open = true
	preview_icon.texture = load(closest.get_icon_path())
	if not closest.is_interactable(self):
		preview_icon.texture = preload("res://assets/X.png")
		return

	if interaction_cooldown <= 0 and Input.is_action_pressed("interact"):
		interaction_cooldown = max_interaction_cooldown
		closest.interact(self)

func add_drink(drink_type):
	items.append(drink_type)
	for i in range(items_limit):
		var sprite = get_node(drink_sprites[i])
		if !sprite.visible:
			sprite.visible = true
			sprite.texture = load(drink_icons[drink_type])
			break

func remove_drink(drink_type):
	for i in range(items.size()):
		if items[i] == drink_type:
			items.erase(items[i])
			get_node(drink_sprites[i]).visible = false;
			break

func clear_drinks():
	items = []
	for drink in drink_sprites:
		get_node(drink).visible = false;

func move():
	var velocity = Vector2()
	var play_anim = "idle"
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
	if !previous_bubble_open and bubble_open:
		$SpeechBubble/AnimationPlayer.play("opening")
		$SpeechBubble/PreviewIcon.visible = false
	previous_bubble_open = bubble_open
	velocity = velocity.normalized() * speed
	velocity = move_and_slide(velocity)
	anim_player.play(play_anim)
