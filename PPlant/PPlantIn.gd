extends Node2D

func _ready():
	pass # Replace with function body.



func _on_LineEdit_text_changed(new_text):
	$CanvasLayer/LineEdit.set_text(new_text)
		
