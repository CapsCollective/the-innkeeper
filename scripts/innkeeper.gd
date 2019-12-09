extends KinematicBody2D

export (int) var max_interaction_cooldown = 100
export (int) var speed = 200
export (int) var items_limit

onready var anim_player = $AnimationPlayer
onready var interaction_range = $InteractionRange

var items = []
var available_interactable = null
var interaction_cooldown = 0

func _physics_process(_delta):
	check_interactions()
	display_interactions()
	move()
	
	if interaction_cooldown > 0:
		interaction_cooldown -= 1
	print(items)

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
	if interaction_cooldown <= 0 and items.size() < items_limit and available_interactable:
		if Input.is_action_pressed("interact"):
			items.append(available_interactable.dispense())
			interaction_cooldown = max_interaction_cooldown

func move():
	var velocity = Vector2()
	if Input.is_action_pressed('right'):
		velocity.x += 1
	if Input.is_action_pressed('left'):
		velocity.x -= 1
	if Input.is_action_pressed('down'):
		velocity.y += 1
	if Input.is_action_pressed('up'):
		velocity.y -= 1
	velocity = velocity.normalized() * speed
	velocity = move_and_slide(velocity)
	play_animation(velocity)

func play_animation(velocity):
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
