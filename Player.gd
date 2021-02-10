extends KinematicBody2D

var speed = 45  # speed in pixels/sec

var velocity = Vector2.ZERO

var radioact = 0
var health = 100

var is_inside_lagoon = false

#enum state {in_game, in_fight}


var items = []
var attacks = ["bare_hands", "rock_throw"]

var in_game = true 
func ready():
	pass
	

func get_input():
	if in_game:
		velocity = Vector2.ZERO
		if Input.is_action_pressed('move_right'):
			velocity.x += 1
		if Input.is_action_pressed('move_left'):
			velocity.x -= 1
			
		if Input.is_action_pressed('move_down'):
			velocity.y += 1
		if Input.is_action_pressed('move_up'):
			velocity.y -= 1

		velocity = velocity.normalized() * speed

##show waring
#get_tree().current_scene.get_node("CanvasL").get_node("Warning").visible = true
	
func _physics_process(delta):
	get_input()
	velocity = move_and_slide(velocity)

func _on_RadTimer_timeout():
	if is_inside_lagoon:
		radioact += 2
