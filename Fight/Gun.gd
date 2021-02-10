extends Node2D

var finished = false
var min_damage = 49
var max_damage = 79
var prec = 90

onready var anim_player = $AnimationPlayer
func play_anim(anim):
	if anim_player.current_animation == anim:
		return
	anim_player.play(anim)

func _process(delta):
	if finished:
		queue_free()
		finished = false

func _on_AnimationPlayer_animation_finished(anim_name):
	var a = anim_name
	finished = true

func do_anim():
	play_anim("shoot")
