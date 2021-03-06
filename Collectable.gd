extends Area2D

enum ctype {IODE, HEALTH_1, HEALTH_2, HEALTH_3, GUN, SWORD, BULLET, ROCK}

export (ctype) var collectable_type

onready var anim_player = $AnimationPlayer
onready var sprite = $Sprite
onready var textures = [
		load("res://Assets/health_coll.png"),
		load("res://Assets/health_coll2.png"),
		load("res://Assets/health_coll3.png"),
		load("res://Assets/pots.png"),
		load("res://Assets/Fight/gun.png"),
		load("res://Assets/Fight/sword.png"),
		load("res://Assets/Fight/rock.png")]

func _ready():
	play_anim("float_base")
	match collectable_type:
		ctype.HEALTH_1:
			sprite.texture = textures[0]
		ctype.HEALTH_2:
			sprite.texture = textures[1]
		ctype.HEALTH_3:
			sprite.texture = textures[2]
		ctype.IODE:
			sprite.texture = textures[3]
		ctype.GUN:
			sprite.texture = textures[4]
		ctype.SWORD:
			sprite.texture = textures[5]
		ctype.ROCK:
			sprite.texture = textures[6]
			
func play_anim(anim):
	if anim_player.current_animation == anim:
		return
	anim_player.play(anim)


func _on_Collectable_body_entered(body):
	if body.is_in_group("player"):
		print("Collected")		
		if body.health < 100:
			body.radioact += 2
			match collectable_type:
				ctype.HEALTH_1:
					body.health += 10
				ctype.HEALTH_2:
					body.health += 20
				ctype.HEALTH_3:
					body.health += 30
			
			if body.health > 100:
				body.health = 100 
		
		if collectable_type == ctype.IODE:
			if body.radioact > 0:
				body.radioact -= 10
			
			if body.radioact < 0:
				body.radioact = 0
		
		if collectable_type == ctype.GUN:
			body.gun = true
			body.bullets += 2
		if collectable_type == ctype.SWORD:
			body.sword = true
		if collectable_type == ctype.ROCK:
			body.rocks += 10
		
		queue_free()
		
