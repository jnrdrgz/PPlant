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
var enemy_str 

func _ready():
	#play_anim("float_base")
	match enemy_type:
		ctype.BAT:
			sprite.texture = textures[0]
			health = 10
			enemy_str = "bat"
		ctype.CROCO:
			sprite.texture = textures[1]
			health = 20
			enemy_str = "croco"
		ctype.PHANTOM:
			sprite.texture = textures[2]
			health = 50
			enemy_str = "phantom"
			
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
