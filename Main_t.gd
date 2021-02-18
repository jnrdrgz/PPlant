extends Node2D

var m_loaded = false
var menu_scene = preload("res://Menu.tscn").instance()
	
func _ready():
	pass

func _process(delta):
	$CanvasL/Health/Number.text = str($YSort/Player.health)
	$CanvasL/Radioactivity/Number.text = str($YSort/Player.radioact)
	
	if $YSort/Player.dead and not m_loaded:
		m_loaded = true
		goToMenu()
	
	if $YSort/Player.in_game:
		Sound.play("nuclear_bip")
		
func goToMenu():
	get_tree().change_scene("res://Menu.tscn")

