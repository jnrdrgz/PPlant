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
var run_prob = 0
var max_att = 0
var less_att = 0
var enemy_str 

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
			health = 10
			enemy_str = "bat"
			run_prob = 75
			less_att = 5
			max_att = 20
			
		ctype.CROCO:
			sprite.texture = textures[1]
			health = 20
			enemy_str = "croco"
			run_prob = 40
			less_att = 20
			max_att = 60

		ctype.PHANTOM:
			sprite.texture = textures[2]
			health = 50
			enemy_str = "phantom"
			run_prob = 2
			less_att = 60
			max_att = 80

func play_anim(anim):
	return ###borrar
	if anim_player.current_animation == anim:
		return
	anim_player.play(anim)

var fight_scene = preload("res://Fight/FightScene.tscn").instance()
func enter_fight(player):
	fight_scene.enemy = enemy_str
	fight_scene.player_attacks = player.attacks
	fight_scene.n_enemies = number
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
