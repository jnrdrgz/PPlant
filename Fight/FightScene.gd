extends Node2D

var enemy : String
var n_enemies : int
var player_attacks : Array
var player_items : Array
#onready var enemy_scene = preload("res://Enemy.tscn")#.instance()

var turn = true

func _ready():
	print("Fight entered")
	print("Enemy:")
	print(enemy)
	print("Attacks:")
	for i in range(n_enemies):
		var enemy_scene = load("res://Enemy.tscn")
		var enemy_ins = enemy_scene.instance()
		enemy_ins.connect("selectedSignal", self, "test_s")		
		enemy_ins.scale = Vector2(3,3)
		enemy_ins.set_name("Enemy")
		if enemy == "bat":
			enemy_ins.enemy_type = enemy_ins.ctype.BAT
		if enemy == "croco":
			enemy_ins.enemy_type = enemy_ins.ctype.CROCO
		if enemy == "phantom":
			enemy_ins.enemy_type = enemy_ins.ctype.PHANTOM
		
		enemy_ins.in_fight = true
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

func do_attack(att):
	var sc = "res://Fight/Gun.tscn"
	if att == "gun":
		sc = "res://Fight/Gun.tscn"
	if att == "sword":
		sc = "res://Fight/Sword.tscn"
	if att == "rock":
		sc = "res://Fight/Rock.tscn"
	
	var attack_scene = load(sc)
	var attack_ins = attack_scene.instance()
	
	#attack_ins.scale = Vector2(3,3)
	
	if get_node("AttackPosRef"):
		get_node("AttackPosRef").add_child(attack_ins)
		attack_ins.do_anim()
	else:
		print_tree()
		print("no scene")
		

func test_s():
	print("SELECTED")
	for e in $Enemies.get_children():
		if e.has_node("Enemy"):
			e.get_node("Enemy").deselect()
				
func _on_BareHands_pressed():
	print("Bare hands attack")
	#$Player.do_bare_hands_attack()

func do_turn(att):
	if turn:
		do_attack(att)
		#turn = false

func _on_Gun_pressed():
	do_turn("gun")

func _on_Knife_pressed():
	do_turn("sword")

func _on_Rock_pressed():
	do_turn("rock")
