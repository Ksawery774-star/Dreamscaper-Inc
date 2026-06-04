extends Node

# Example card effect for "Fear of Failure"

func apply_effect(player, dream_world):
	print("Fear of Failure activated!")
	# Increase risk
	dream_world.instability += 20
	# But boost damage
	player.damage_multiplier += 1.5
	# TODO: Visual effects, risk of collapse
