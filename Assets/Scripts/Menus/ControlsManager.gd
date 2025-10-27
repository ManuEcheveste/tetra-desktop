class_name ControlsManager
extends Control

@onready var keyBindResource : PlayerConfig = preload("res://Prefabs/DefaultPlayerKeybinds.tres")
@onready var p1MLButton: KeyBindsManager = $"PanelContainer/MarginContainer/TabContainer/Player 1/ScrollContainer/MarginContainer/VBoxContainer/MoveLeft/Button"
@onready var p1MRButton: KeyBindsManager = $"PanelContainer/MarginContainer/TabContainer/Player 1/ScrollContainer/MarginContainer/VBoxContainer/MoveRight/Button"
@onready var p1SDButton: KeyBindsManager = $"PanelContainer/MarginContainer/TabContainer/Player 1/ScrollContainer/MarginContainer/VBoxContainer/SoftDrop/Button"
@onready var p1HDButton: KeyBindsManager = $"PanelContainer/MarginContainer/TabContainer/Player 1/ScrollContainer/MarginContainer/VBoxContainer/HardDrop/Button"
@onready var p1CWButton: KeyBindsManager = $"PanelContainer/MarginContainer/TabContainer/Player 1/ScrollContainer/MarginContainer/VBoxContainer/ClockWise/Button"
@onready var p1CCWButton: KeyBindsManager = $"PanelContainer/MarginContainer/TabContainer/Player 1/ScrollContainer/MarginContainer/VBoxContainer/CounterClockWise/Button"
@onready var p1_180Button: KeyBindsManager = $"PanelContainer/MarginContainer/TabContainer/Player 1/ScrollContainer/MarginContainer/VBoxContainer/Rotate180/Button"
@onready var p1HoldButton: KeyBindsManager = $"PanelContainer/MarginContainer/TabContainer/Player 1/ScrollContainer/MarginContainer/VBoxContainer/Hold/Button"


func ResetPlayerControls(player: int = 0):
	PlayerConfig.new().SetDefaultKeybinds(player)
	if player != 2:
		p1MLButton.UpdateKeybindDisplay()
		p1MRButton.UpdateKeybindDisplay()
		p1SDButton.UpdateKeybindDisplay()
		p1HDButton.UpdateKeybindDisplay()
		p1CWButton.UpdateKeybindDisplay()
		p1CCWButton.UpdateKeybindDisplay()
		p1_180Button.UpdateKeybindDisplay()
		p1HoldButton.UpdateKeybindDisplay()

func CheckForDuplicates():
	var key_map = {}
	var buttons = [p1MLButton, p1MRButton, p1SDButton, p1HDButton, p1CWButton, p1CCWButton, p1_180Button, p1HoldButton]
	
	for button in buttons:
		if is_instance_valid(button):
			var key = Scripter.GetKeybindKey(button.GetAction())
			if not key_map.has(key):
				key_map[key] = []
			key_map[key].append(button)
	
	for button in buttons:
		if is_instance_valid(button):
			button.ShowWarning(false)
	
	for key in key_map:
		if key_map[key].size() > 1:  # Si hay duplicados
			for button in key_map[key]:
				button.ShowWarning(true)
