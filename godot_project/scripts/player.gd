extends CharacterBody2D
class_name Player

# Basic Player with Trauma Deck

@export var max_health: int = 100
var current_health: int = 100
var trauma_deck: Array = []
var hand: Array = []

signal card_played(card: TraumaCard)

func _ready():
	print("Player initialized with trauma deck")
	# TODO: Load starting deck from GameManager

func add_card_to_deck(card: TraumaCard):
	trauma_deck.append(card)

func draw_hand(amount: int = 3):
	hand.clear()
	for i in range(min(amount, trauma_deck.size())):
		hand.append(trauma_deck[i])  # Simple draw, later shuffle

func play_card(card: TraumaCard, target = null):
	if card in hand:
		hand.erase(card)
		emit_signal("card_played", card)
		# Apply effects via DreamGenerator or GameManager
		print("Played: ", card.name)
		# TODO: Call card effect

func take_damage(amount: int):
	current_health -= amount
	if current_health <= 0:
		print("Player defeated - Dream collapse?")