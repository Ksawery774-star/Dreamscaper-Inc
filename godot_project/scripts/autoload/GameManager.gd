extends Node

# GameManager - centralny menedżer gry
# Zarządza stanem gry, deckami, runami snów

signal trauma_resolved(trauma_id: String)
signal dream_collapse()

var player_traumas: Array = []
var current_dream: Dictionary = {}

var deck: Array = []  # Trauma cards

func _ready():
	print("Dreamscaper Inc - GameManager initialized")
	# TODO: Load starting deck

func add_trauma(trauma_data: Dictionary):
	player_traumas.append(trauma_data)
	# Update deck

func start_dream_run():
	# Generate dream based on traumas
	print("Entering dream...")
	# TODO: Procedural generation

func resolve_trauma(trauma_id: String):
	emit_signal("trauma_resolved", trauma_id)
	# Remove or transform card
