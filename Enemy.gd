extends Area2D

enum ctype {BAT, CROCO, PHANTOM}

export (ctype) var enemy_type
export (int) var number

onready var anim_player = $AnimationPlayer
onready var sprite = $Sprite
onready var textures = [
		load("res://Assets/bat.png"),
		load("res://Assets/enemy_croco.png"),
		load("res://Assets/phantom.png")]

var health = 0
var max_health = 0
var run_prob = 0
var min_att = 0
var max_att = 0
var less_att = 0
var enemy_str 

var turn = false
var in_fight = false
var selected = false

func _ready():
	#$CanvasLayer.offset = position
	#play_anim("float_base")
	if in_fight:
		$UI/Label.visible = true
	
	match enemy_type:
		ctype.BAT:
			sprite.texture = textures[0]
			max_health = 50
			enemy_str = "bat"
			run_prob = 75
			less_att = 5
			min_att = 5
			max_att = 10
			
		ctype.CROCO:
			sprite.texture = textures[1]
			max_health = 100
			enemy_str = "croco"
			run_prob = 40
			less_att = 20
			min_att = 15
			max_att = 30

		ctype.PHANTOM:
			sprite.texture = textures[2]
			max_health = 250
			enemy_str = "phantom"
			run_prob = 2
			less_att = 60
			min_att = 20
			max_att = 40
	
	health = max_health
	sub_health(0) ##sub 0 to update the label
		
		
func play_anim(anim):
	if anim_player.current_animation == anim:
		return
	anim_player.play(anim)

var fight_scene = preload("res://Fight/FightScene.tscn").instance()
func enter_fight(player):
	fight_scene.enemy = enemy_str
	fight_scene.player_attacks = player.attacks
	fight_scene.n_enemies = number
	
	fight_scene.gun = player.gun
	fight_scene.sword = player.sword
	fight_scene.bullets = player.bullets
	fight_scene.rocks = player.rocks
	
	fight_scene.get_node("Camera2D").current = true
	
	get_tree().get_root().add_child(fight_scene)
	
	queue_free()

var already_entered_fight = false
func _on_Enemy_body_entered(body):
	if body.is_in_group("player"):
		if not already_entered_fight:
			enter_fight(body)
			already_entered_fight = true

func deselect():
	$Square.visible = false
	selected = $Square.visible

signal selectedSignal
func _on_TextureButton_pressed():
	if in_fight:
		if !$Square.visible:
			emit_signal("selectedSignal")
	
		$Square.visible = !$Square.visible
		selected = $Square.visible

signal enemyDeadSignal
func sub_health(q):
	health -= q
	if health < 0:
		health = 0
		emit_signal("enemyDeadSignal")
		queue_free()
	else:
		$UI/Label.text = str(health) + "/" + str(max_health)

var rng = RandomNumberGenerator.new()
func take_turn(player):
	if player:
		rng.randomize()
		player.health -= rng.randi_range(min_att,max_att)
		play_anim("attack")
		print("Enemy attacked")	
	else:
		print("Enemy not attacked, null player")	

signal endAttackAnimSignal
func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "attack":
		emit_signal("endAttackAnimSignal")
		print("END ENEMY TURN")
	if anim_name == "receive_damage":
		pass
