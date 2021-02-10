extends Label

export (String) var btn_text

func _ready():
	set_text(btn_text)
	#print(get_node("Label").text)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
