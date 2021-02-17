extends Node2D


onready var nucelar_bip = $NuclearBip
onready var walking = $Steps

var sound_enabled = true

func _ready():
	pass # Replace with function body.

func play(name):
	if sound_enabled:
		if name == "nuclear_bip" and not nucelar_bip.playing:
			nucelar_bip.play()
		if name == "walking" and not walking.playing:
			walking.play()
	
func stop(name):
	if name == "nuclear_bip" and nucelar_bip.playing:
		nucelar_bip.stop()
	if name == "walking" and walking.playing:
		walking.stop()
	
