extends Resource
class_name TraumaCardsData

# Central data for all trauma cards

const CARDS = [
	{"id": "fear_failure", "name": "Fear of Failure", "type": "fear", "power": 3, "cost": 1, "desc": "High risk, high reward"},
	{"id": "abandonment", "name": "Abandonment", "type": "loss", "power": 2, "cost": 1, "desc": "Echoes follow you"},
	{"id": "perfectionism", "name": "Perfectionism", "type": "control", "power": 4, "cost": 2, "desc": "Stronger but costly"},
	{"id": "childhood", "name": "Childhood Innocence", "type": "nostalgia", "power": 1, "cost": 0, "desc": "Safe but revealing"},
	{"id": "betrayal", "name": "Betrayal", "type": "trust", "power": 3, "cost": 1, "desc": "Ally or attack?"},
	{"id": "dread", "name": "Existential Dread", "type": "void", "power": 5, "cost": 3, "desc": "The end approaches"}
]

static func get_card(id: String) -> Dictionary:
	for card in CARDS:
		if card.id == id:
			return card
	return {}
