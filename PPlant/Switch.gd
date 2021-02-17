extends Area2D

var player_inside = false

signal switched

func _ready():
	pass
	
func switch():
	#print("siwtichng")
	$Sprite.flip_h = !$Sprite.flip_h
	emit_signal("switched")
	
func _process(delta):
	if Input.is_action_pressed("trigger_action"):
		if player_inside:
			switch()
	

func _on_Switch_body_entered(body):
	if body.is_in_group("player"):
		#check in game
		player_inside = true		
		$Label.show()

func _on_Switch_body_exited(body):
	if body.is_in_group("player"):
		player_inside = false
		$Label.hide()
