extends KinematicBody2D

var speed = 85  # speed in pixels/sec

var velocity = Vector2.ZERO

var radioact = 0
var health = 100

var is_inside_lagoon = false

#enum state {in_game, in_fight}

var is_actioning_switch = false

var items = []
var attacks = ["bare_hands", "rock_throw"]

var in_game = true 
var dead = false

var gun = true
var sword = true
var bullets = 10
var rocks = 10

onready var anim_player = $AnimationPlayer
func play_anim(anim):
	if anim_player.current_animation == anim:
		return
	anim_player.play(anim)

func ready():
	pass

func _process(delta):
	if dead:
		##print("dead")
		#dead etccccccccccccccccc
		#todo
		pass

func get_input():
	if in_game:
		velocity = Vector2.ZERO
		var walking = false
		if Input.is_action_pressed('move_right'):
			velocity.x += 1		
			walking = true
	
		if Input.is_action_pressed('move_left'):
			velocity.x -= 1
			walking = true
			
		if Input.is_action_pressed('move_down'):
			velocity.y += 1
			walking = true
			
		if Input.is_action_pressed('move_up'):
			velocity.y -= 1
			walking = true
		
		if walking:
			play_anim("walking")
			Sound.play("walking")
		else:
			Sound.stop("walking")
		
		velocity = velocity.normalized() * speed
	else:
		velocity = Vector2.ZERO
		

##show waring
#get_tree().current_scene.get_node("CanvasL").get_node("Warning").visible = true
	
func _physics_process(delta):
	get_input()
	velocity = move_and_slide(velocity)

func _on_RadTimer_timeout():
	if is_inside_lagoon:
		radioact += 2
	
	if radioact >= 100:
		health -= 1
