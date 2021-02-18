extends Node2D

var enemy : String
var n_enemies : int
var player_attacks : Array
var player_items : Array

var turn = true
var player_dead = false
var enemy_attacked = false

var run_prob = 100
 
var gun = false
var sword = false
var bullets = 0
var rocks = 0

func _ready():
	print("Fight entered")
	print("Enemy:")
	print(enemy)
	print("Attacks:")
	for i in range(n_enemies):
		var enemy_scene = load("res://Enemy.tscn")
		var enemy_ins = enemy_scene.instance()
		enemy_ins.connect("selectedSignal", self, "test_s")		
		enemy_ins.connect("endAttackAnimSignal", self, "changeTurn")		
		enemy_ins.connect("enemyDeadSignal", self, "deadEnemyCount")		
		enemy_ins.scale = Vector2(4,4)
		enemy_ins.set_name("Enemy")
		if enemy == "bat":
			enemy_ins.enemy_type = enemy_ins.ctype.BAT
		if enemy == "croco":
			enemy_ins.enemy_type = enemy_ins.ctype.CROCO
		if enemy == "phantom":
			enemy_ins.enemy_type = enemy_ins.ctype.PHANTOM
		
		enemy_ins.in_fight = true
		enemy_ins._ready()
		run_prob = enemy_ins.run_prob
		
		get_node("Enemies/" + "Enemy" + str(i+1)).add_child(enemy_ins)
		
	for pa in player_attacks:
		print(pa)

func changeTurn():
	print("TURN CHANGED")
	var pl = get_parent().get_node("Main").get_node("YSort/Player")
	pl.bullets = bullets
	pl.rocks = rocks
	if pl.health <= 0:
		player_dead = true
		#pl.dead = true
	$PTurnTimer.start()
	
var dead_enemies = 0
func _process(delta):
	if Input.is_action_pressed("ui_select"):
		print("timed")
		create_timer_and_free("Runned manually")
	
	if !turn and !enemy_attacked:
		enemy_take_turn()
		enemy_attacked = true
	
	if dead_enemies == n_enemies:
		create_timer_and_free("ALL ENEMIES DEFEATED, CONTINUE YOUR JOURNEY!", 5)
		
	if player_dead:
		create_timer_and_free_dead("YOU'RE DEAD", 5)
	
func create_timer_and_free(message = "", limit = 4):
	##set message
	$CanvasLayer/Messages.show()
	$CanvasLayer/Messages.text = message
	var timer = Timer.new()
	timer.set_wait_time(limit)
	timer.connect("timeout",self,"queue_free") 
	add_child(timer) 
	timer.start() 

func create_timer_and_free_dead(message = "", limit = 4):
	##set message
	$CanvasLayer/Messages.show()
	$CanvasLayer/Messages.text = message
	var timer = Timer.new()
	timer.set_wait_time(limit)
	timer.connect("timeout",self,"queue_free_and_pl_dead") 
	add_child(timer) 
	timer.start() 

func queue_free_and_pl_dead():
	if player_dead:
		var pl = get_parent().get_node("Main").get_node("YSort/Player")
		pl.dead = true
	
	queue_free()

	
func create_message(message = ""):
	$CanvasLayer/Messages.show()
	$CanvasLayer/Messages.text = message
	

func show_message_and_free():
	$CanvasLayer/Messages.show()
	queue_free()
		
func deadEnemyCount():
	dead_enemies += 1	
	

func enemy_take_turn():
	print("TREE:")
	var pl = get_parent().get_node("Main").get_node("YSort/Player")
	for e in $Enemies.get_children():
		if e.has_node("Enemy"):
			#print(get_tree().current_scene)
			e.get_node("Enemy").take_turn(pl) #??
			create_message("Enemy attacked you!!")

			
		
	#turn = true

##attack back
func _on_Back_pressed():
	$CanvasLayer/Attacks.visible = false
	$CanvasLayer/MainMenu.visible = true	

var rng = RandomNumberGenerator.new()
var player_attacked = false
func do_attack(att):
	if not player_attacked:
		player_attacked = true
		var sc = "res://Fight/Gun.tscn"
		if att == "gun":
			sc = "res://Fight/Gun.tscn"
			if bullets > 0:
				bullets -= 1
				print(bullets)
		if att == "sword":
			sc = "res://Fight/Sword.tscn"
		if att == "rock":
			sc = "res://Fight/Rock.tscn"
			if rocks > 0:
				rocks -= 1
				print(rocks)
		if att == "bare_hands":
			sc = "res://Fight/BareHands.tscn"
		
		var attack_scene = load(sc)
		var attack_ins = attack_scene.instance()
		attack_ins.connect("endAttackAnimSignal", self, "changeTurn")
		
		for e in $Enemies.get_children():
			if e.has_node("Enemy"):
				if e.get_node("Enemy").selected:
					rng.randomize()
					var will_hit = rng.randi_range(0, 100)
					if will_hit > attack_ins.prec:
						print("miss")
						create_message("OH NO, you miised !!")

					
					var dam = rng.randi_range(attack_ins.min_damage, attack_ins.max_damage)
					e.get_node("Enemy").sub_health(dam)
					e.get_node("Enemy").deselect()
					e.get_node("Enemy").play_anim("receive_damage")
					create_message("Enemy hitted !!")
					
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

var attacking = false
func do_turn(att):
	if turn:
		var is_one_selected = false
		for e in $Enemies.get_children():
			if e.has_node("Enemy"):
				if e.get_node("Enemy").selected:
					is_one_selected = true	
			if is_one_selected:
				do_attack(att)

				$PTurnTimer.start()
			else:
				print("no selected")
	else:	
		print("not your turn")

func _on_Gun_pressed():
	if gun:
		if bullets > 0:
			do_turn("gun")
		else:
			create_message("Out of bullets!")
	else:
		create_message("You don't have a gun yet!")

func _on_Knife_pressed():
	if sword:
		do_turn("sword")
	else:
		create_message("You don't have a sword yet!")

func _on_Rock_pressed():
	if rocks > 0:
		do_turn("rock")
	else:
		create_message("Out of rocks!")
				
func _on_BareHands_pressed():
	do_turn("bare_hands")

func _on_PTurnTimer_timeout():
	turn = !turn
	enemy_attacked = false
	player_attacked = false

func _on_RunButton_pressed():
	if turn:
		rng.randomize()
		var n = rng.randi_range(0,100)
		print(n)
		print(run_prob)
		if n < run_prob:
			create_timer_and_free("Run succesfully!")
		else:
			create_message("CANNOT RUN!")
			turn = false
