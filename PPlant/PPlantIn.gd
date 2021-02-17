extends Node2D

var ans = 0

func _ready():
	$CanvasLayer/TextureRect.hide()
	$CanvasLayer/LineEdit.hide()
	$CanvasLayer/Label.hide()
	$CanvasLayer/SubmitButton.hide()

func _on_LineEdit_text_changed(new_text):
	#$CanvasLayer/LineEdit.set_text(new_text)
	pass

func _process(delta):
	if Input.is_action_pressed("ui_accept"):
		check_ans()
		

var rng = RandomNumberGenerator.new()
func _on_Switch_switched():
	rng.randomize()
	var n1 = rng.randi_range(2,10)
	var n2 = rng.randi_range(2,4)
	
	ans = pow(n1, n2)
	
	var format_string = "How much is %d to the power of %d?"
	var actual_string = format_string % [n1,n2]
	$CanvasLayer/Label.text = actual_string
	
	$CanvasLayer/TextureRect.show()
	$CanvasLayer/LineEdit.show()
	$CanvasLayer/Label.show()
	$CanvasLayer/SubmitButton.show()
	$CanvasLayer/LineEdit.grab_focus()
	$YSort/Player.in_game = false

func check_ans():
	var r = int($CanvasLayer/LineEdit.text)
	print(r)
	if r:
		if r == ans:
			$CanvasLayer/TextureRect.hide()
			$CanvasLayer/LineEdit.hide()
			$CanvasLayer/Label.hide()
			$CanvasLayer/SubmitButton.hide()
			$YSort/Player.in_game = true

func _on_SubmitButton_pressed():
	print("pressed")
	check_ans()

func _on_SubmitButton_button_down():
	print("pressed")
		
