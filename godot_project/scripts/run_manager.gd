extends Node

# Run Manager - controls the flow of one dream run

@onready var game_manager = get_node("/root/GameManager")
@onready var dream_generator = $DreamGenerator
@onready var player = $Player
@onready var event_system = $DreamEventSystem
@onready var card_system = $CardPlaySystem

var current_dream: Dictionary = {}

var run_active: bool = false

func start_new_run():
	run_active = true
	print("Starting new dream run...")
	
	# Get player traumas
	var traumas = game_manager.player_traumas if game_manager else []
	
	# Generate dream
	current_dream = dream_generator.generate_dream(traumas)
	print("Dream generated: ", current_dream.name)
	print("Boss: ", current_dream.boss)
	
	# Setup player
	if player:
		player.draw_hand(3)
		print("Hand drawn: ", player.hand.size(), "cards")
	
	# Start first room
	process_next_room()

func process_next_room():
	if not run_active or current_dream.rooms.is_empty():
		end_run()
		return
	
	var room = current_dream.rooms.pop_front()
	print("Entering room: ", room.type)
	
	if event_system:
		event_system.trigger_room_event(room.type, game_manager.player_traumas if game_manager else [])
	
	# TODO: Wait for player action or timer, then next room

func end_run():
	run_active = false
	print("Dream run ended. Returning to hub...")
	# TODO: Rewards, trauma resolution, back to agency hub
