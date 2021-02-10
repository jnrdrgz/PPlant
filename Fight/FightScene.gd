extends Node2D

var enemy : String
var n_enemies : int
var player_attacks : Array
var player_items : Array
#onready var enemy_scene = preload("res://Enemy.tscn")#.instance()

func _ready():
	print("Fight entered")
	print("Enemy:")
	print(enemy)
	print("Attacks:")
	for i in range(n_enemies):
		var enemy_scene = load("res://Enemy.tscn")
		var enemy_ins = enemy_scene.instance()
			
		enemy_ins.scale = Vector2(3,3)
		
		if enemy == "bat":
			enemy_ins.enemy_type = enemy_ins.ctype.BAT
		if enemy == "croco":
			enemy_ins.enemy_type = enemy_ins.ctype.CROCO
		if enemy == "phantom":
			enemy_ins.enemy_type = enemy_ins.ctype.PHANTOM
		
		enemy_ins._ready()
		
		
		
		get_node("Enemies/" + "Enemy" + str(i+1)).add_child(enemy_ins)
		
	for pa in player_attacks:
		print(pa)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("ui_select"):
		queue_free()

##attack back
func _on_Back_pressed():
	$CanvasLayer/Attacks.visible = false
	$CanvasLayer/MainMenu.visible = true	

func _on_BareHands_pressed():
	print("Bare hands attack")
	#$Player.do_bare_hands_attack()
