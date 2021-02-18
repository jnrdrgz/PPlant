extends Area2D

func _on_PPlantOut_body_entered(body):
	if body.is_in_group("player"):
		get_tree().change_scene("res://PPlant/PPlantIn.tscn")
