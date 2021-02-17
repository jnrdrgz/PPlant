extends Area2D

func _ready():
	pass
	
func _on_PPlantOut_body_entered(body):
	if body.is_in_group("player"):
		pass	
