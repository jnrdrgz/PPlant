extends Area2D

var add_rad = false

func _ready():
	pass 

func _on_Lagoon_body_entered(body):
	body.radioact += 10
	if body.is_in_group("player"):
		body.is_inside_lagoon = true

func _on_Lagoon_body_exited(body):
	if body.is_in_group("player"):
		body.is_inside_lagoon = false
