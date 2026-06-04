extends Node

# Simple Input Handler for playing cards

@onready var player = get_node_or_null("../Player")
@onready var card_system = get_node_or_null("../CardPlaySystem")
@onready var run_manager = get_node_or_null("../RunManager")

var current_hand_index: int = 0

func _process(delta):
	if not player or not run_manager or not run_manager.run_active:
		return
	
	# Simple keyboard input to play cards (1-3 for first 3 cards in hand)
	if Input.is_action_just_pressed("play_card_1") and player.hand.size() > 0:
		play_card_from_hand(0)
	elif Input.is_action_just_pressed("play_card_2") and player.hand.size() > 1:
		play_card_from_hand(1)
	elif Input.is_action_just_pressed("play_card_3") and player.hand.size() > 2:
		play_card_from_hand(2)
	
	# Debug: print hand
	if Input.is_action_just_pressed("debug_print_hand"):
		print_hand()

func play_card_from_hand(index: int):
	if index < player.hand.size():
		var card = player.hand[index]
		player.play_card(card)
		if card_system:
			card_system._on_card_played(card)
		print("Played card: ", card.name if card else "unknown")
		# Remove from hand after play (simple version)
		player.hand.remove_at(index)

func print_hand():
	print("Current hand:")
	for i in range(player.hand.size()):
		var c = player.hand[i]
		print(i+1, ": ", c.name if c else "?")