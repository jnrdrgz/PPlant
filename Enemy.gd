extends Area2D

enum ctype {BAT, CROCO, PHANTOM}

export (ctype) var collectable_type

onready var anim_player = $AnimationPlayer
onready var sprite = $Sprite
onready var textures = [
		load("res://Assets/bat.png"),
		load("res://Assets/enemy_croco.png"),
		load("res://Assets/phantom.png")]

var health = 0

func _ready():
	play_anim("float_base")
	match collectable_type:
		ctype.BAT:
			sprite.texture = textures[0]
			health = 10
		ctype.CROCO:
			sprite.texture = textures[1]
			health = 20
		ctype.PHANTOM:
			sprite.texture = textures[2]
			health = 50
			
func play_anim(anim):
	return ###borrar
	if anim_player.current_animation == anim:
		return
	anim_player.play(anim)

var fight_scene = preload("res://FightScene.tscn").instance()
func enter_fight():
	fight_scene.get_node("Camera2D").current = true
	get_tree().get_root().add_child(fight_scene)
	
	queue_free()
	
func _on_Enemy_body_entered(body):
	if body.is_in_group("player"):
		enter_fight()
