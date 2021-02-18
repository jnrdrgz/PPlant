extends Area2D

var player_inside = false
var already_emmited = false

signal switched
var switched = false

func _ready():
	pass
	
func switch():
	#print("siwtichng")
	$Sprite.flip_h = !$Sprite.flip_h
	switched = true
	
func _process(delta):
	if Input.is_action_pressed("trigger_action"):
		if player_inside && not already_emmited:
			emit_signal("switched")
			#already_emmited = true
			
func _on_Switch_body_entered(body):
	if body.is_in_group("player"):
		#check in game
		player_inside = true		
		$Label.show()
		
func _on_Switch_body_exited(body):
	if body.is_in_group("player"):
		player_inside = false
		$Label.hide()
