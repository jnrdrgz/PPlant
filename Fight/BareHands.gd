extends Node2D

var finished = false
var min_damage = 5
var max_damage = 20
var prec = 100

onready var anim_player = $AnimationPlayer
func play_anim(anim):
	if anim_player.current_animation == anim:
		return
	anim_player.play(anim)

func _process(delta):
	if finished:
		queue_free()
		finished = false

signal endAttackAnimSignal
func _on_AnimationPlayer_animation_finished(anim_name):
	var a = anim_name
	finished = true
	emit_signal("endAttackAnimSignal")

func do_anim():
	play_anim("hit")
