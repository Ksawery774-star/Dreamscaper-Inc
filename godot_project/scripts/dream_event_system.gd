extends Node

# Dream Event System - events triggered by trauma cards and rooms

signal event_triggered(event_data: Dictionary)

func trigger_room_event(room_type: String, player_traumas: Array):
	var event = {}
	match room_type:
		"memory":
			event = {"type": "heal", "amount": 10, "flavor": "A warm memory surfaces..."}
		"nightmare":
			event = {"type": "damage", "amount": 15, "flavor": "The nightmare strikes!"}
		_:
			event = {"type": "nothing", "flavor": "The dream shifts..."}
	
	# Modify by traumas
	for trauma in player_traumas:
		if trauma.get("trauma_type") == "fear" and room_type == "nightmare":
			event.amount = event.get("amount", 0) * 1.5
	
	emit_signal("event_triggered", event)
	print(event.flavor)
