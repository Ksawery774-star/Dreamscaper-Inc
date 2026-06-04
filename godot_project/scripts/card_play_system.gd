extends Node

# Card Play System - handles playing trauma cards in dream

@onready var player: Player = get_node_or_null("../Player")
@onready var dream_generator: DreamGenerator = get_node_or_null("../DreamGenerator")

func _ready():
	if player:
		player.connect("card_played", _on_card_played)

func _on_card_played(card: TraumaCard):
	print("Card played in dream: ", card.name)
	# Apply global effects
	if dream_generator:
		dream_generator.apply_card_effect(card)  # Extend DreamGenerator later
	# Visual feedback, animations, etc.
