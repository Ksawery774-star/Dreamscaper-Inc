# Final Playable Wiring for Dreamscaper Inc - First Playable Prototype
# This script wires all systems together for the first end-to-end playable build
# Attach this to the dream_level scene or use as autoload for testing

extends Node

@onready var run_manager = $RunManager
@onready var player = $Player
@onready var input_handler = $InputHandler
@onready var dream_generator = $DreamGenerator
@onready var event_system = $DreamEventSystem
@onready var card_play_system = $CardPlaySystem

@onready var hand_label = $UI/HandLabel
@onready var status_label = $UI/StatusLabel
@onready var instability_bar = $UI/InstabilityBar

func _ready():
    print("[Dreamscaper] Final wiring initialized - First playable prototype ready!")
    
    # Connect all signals for full loop
    if run_manager:
        run_manager.connect("run_started", _on_run_started)
        run_manager.connect("room_completed", _on_room_completed)
        run_manager.connect("run_ended", _on_run_ended)
    
    if player:
        player.connect("hand_changed", _on_hand_changed)
        player.connect("card_played", _on_card_played)
    
    if input_handler:
        input_handler.connect("card_play_requested", _on_card_play_requested)
    
    # Auto-start for quick testing (remove for full menu flow)
    call_deferred("_auto_start_test_run")

func _auto_start_test_run():
    if run_manager:
        # Start with example traumas for testing
        var test_traumas = ["Fear of Failure", "Abandonment"]
        run_manager.start_new_run(test_traumas)
        print("[Dreamscaper] Auto-started test run with traumas: ", test_traumas)

func _on_run_started(run_data):
    print("[Dreamscaper] Run started! Dream generated with instability: ", run_data.get("instability", 0))
    _update_ui()

func _on_room_completed(room_data):
    print("[Dreamscaper] Room completed: ", room_data.get("type", "unknown"))
    _update_ui()
    # Simple instability increase
    if instability_bar:
        instability_bar.value += 15

func _on_run_ended(result):
    print("[Dreamscaper] Run ended! Result: ", result)
    if result == "victory":
        _show_victory_screen()
    else:
        _show_defeat_screen()

func _on_hand_changed(new_hand):
    if hand_label:
        var hand_text = "Hand: "
        for i in range(new_hand.size()):
            hand_text += str(i+1) + ". " + new_hand[i].name + "  "
        hand_label.text = hand_text

func _on_card_played(card):
    print("[Dreamscaper] Card played: ", card.name)
    _update_ui()

func _on_card_play_requested(card_index):
    if player and card_play_system:
        var success = card_play_system.play_card_from_hand(card_index)
        if success:
            print("[Dreamscaper] Card played successfully from input!")

func _update_ui():
    if status_label and run_manager:
        status_label.text = "Instability: " + str(run_manager.current_instability) + "% | Rooms left: " + str(run_manager.rooms_left)

func _show_victory_screen():
    print("[Dreamscaper] VICTORY! You healed the dream.")
    # TODO: Add actual victory scene transition
    if status_label:
        status_label.text = "VICTORY! Dream healed. Press R to restart."

func _show_defeat_screen():
    print("[Dreamscaper] DEFEAT! The dream collapsed.")
    if status_label:
        status_label.text = "DEFEAT! Dream collapsed. Press R to restart."

func _input(event):
    if event.is_action_pressed("ui_cancel"):  # ESC to quit test
        get_tree().quit()
    if event.is_action_pressed("ui_accept") and status_label and "VICTORY" in status_label.text or "DEFEAT" in status_label.text:
        # Simple restart for testing
        get_tree().reload_current_scene()