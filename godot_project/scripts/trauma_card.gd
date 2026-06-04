extends Resource
class_name TraumaCard

@export var id: String
@export var name: String
@export var description: String
@export var trauma_type: String  # e.g. "fear", "loss", "failure"
@export var power: int = 1
@export var cost: int = 1
@export var effects: Dictionary = {}  # e.g. {"damage": 5, "heal": 2}

# Trauma card - podstawa deckbuildingu
# Karta traumy wpływa na mechaniki snu i postać

func play_card(target):
	print("Playing trauma card: ", name)
	# Apply effects
	# TODO: Implement card effects in dream context
