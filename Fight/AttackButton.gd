extends TextureButton

func _ready():
	pass
	


func _on_AttackButton_pressed():
	#fix
	get_parent().get_parent().get_node("Attacks").visible = true
	get_parent().visible = false
	
