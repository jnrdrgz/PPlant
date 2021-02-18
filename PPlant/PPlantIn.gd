extends Node2D

var ans = 0

var switch

onready var s1 = $YSort/Switch
onready var s2 = $YSort/Switch2
onready var s3 = $YSort/Switch3

func hide_cl():
	$CanvasLayer/TextureRect.hide()
	$CanvasLayer/LineEdit.hide()
	$CanvasLayer/Label.hide()
	$CanvasLayer/CheckLabel.hide()

func show_cl():
	$CanvasLayer/TextureRect.show()
	$CanvasLayer/LineEdit.show()
	$CanvasLayer/Label.show()
	$CanvasLayer/CheckLabel.show()

func _ready():
	hide_cl()

func _on_LineEdit_text_changed(new_text):
	#$CanvasLayer/LineEdit.set_text(new_text)
	pass

func _process(delta):
	if Input.is_action_pressed("ui_accept"):
		check_ans()
		
	if s1.switched and s2.switched and s3.switched:
		#todo
		#winning scene
		get_tree().change_scene("res://WinScene.tscn")

var rng = RandomNumberGenerator.new()
func pop_up():
	rng.randomize()
	var n1 = rng.randi_range(2,10)
	var n2 = rng.randi_range(2,4)
	
	ans = pow(n1, n2)
	
	var format_string = "How much is %d to the power of %d?"
	var actual_string = format_string % [n1,n2]
	$CanvasLayer/Label.text = actual_string
	
	show_cl()
	$CanvasLayer/LineEdit.grab_focus()
	$YSort/Player.in_game = false

var already_popped = false
func _on_Switch_switched():
	if not already_popped:
		switch = $YSort/Switch
		pop_up()
		already_popped = true
	
func _on_Switch2_switched():
	if not already_popped:
		switch = $YSort/Switch2
		pop_up()
		already_popped = true

func _on_Switch3_switched():
	if not already_popped:
		switch = $YSort/Switch3
		pop_up()
		already_popped = true

func check_ans():
	var r = int($CanvasLayer/LineEdit.text)
	print(r)
	if r:
		if r == ans:
			hide_cl()
			$YSort/Player.in_game = true
			
			switch.switch()
			already_popped = false
			return
	
	$CanvasLayer/CheckLabel.text = "Wrong Answer!"	

func _on_SubmitButton_pressed():
	print("pressed")
	check_ans()

func _on_SubmitButton_button_down():
	print("pressed")
		


