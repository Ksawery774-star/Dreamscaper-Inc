extends Node
class_name DreamGenerator

# Procedural Dream Generator
# Generuje poziomy snu na podstawie traum gracza

@export var base_rooms: int = 5

var trauma_modifiers: Dictionary = {}

func generate_dream(player_traumas: Array) -> Dictionary:
	var dream = {
		"name": "Dream of " + str(randi() % 1000),
		"rooms": [],
		"instability": 0,
		"boss": null
	}
	
	# Apply trauma modifiers
	for trauma in player_traumas:
		if trauma.has("trauma_type"):
			_apply_trauma_modifier(dream, trauma)
	
	# Generate rooms
	for i in range(base_rooms + dream.get("extra_rooms", 0)):
		dream.rooms.append({
			"id": i,
			"type": _get_room_type(dream),
			"events": []
		})
	
	# Add boss based on dominant trauma
	dream.boss = _generate_boss(player_traumas)
	
	return dream

func _apply_trauma_modifier(dream: Dictionary, trauma: Dictionary):
	match trauma.get("trauma_type", ""):
		"fear":
			dream.instability += 15
			if not dream.has("extra_rooms"): dream.extra_rooms = 0
			dream.extra_rooms += 2
		"loss":
			dream.instability += 10
		# Add more types...

func _get_room_type(dream: Dictionary) -> String:
	if dream.instability > 50:
		return "nightmare"
	return "memory"

func _generate_boss(traumas: Array) -> Dictionary:
	if traumas.is_empty():
		return {"name": "The Void", "health": 100}
	var dominant = traumas[0]
	return {"name": dominant.get("name", "Shadow"), "health": 80 + dominant.get("power", 1) * 10}
