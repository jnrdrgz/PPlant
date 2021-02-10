extends Node2D

func _ready():
	pass # Replace with function body.

func _process(delta):
	$CanvasL/Health/Number.text = str($YSort/Player.health)
	$CanvasL/Radioactivity/Number.text = str($YSort/Player.radioact)
	
