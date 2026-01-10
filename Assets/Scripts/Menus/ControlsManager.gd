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
@onready var p1ARR: HandlingManager = $"PanelContainer/MarginContainer/TabContainer/Player 1/ScrollContainer/MarginContainer/VBoxContainer/ARR"
@onready var p1DAS: HandlingManager = $"PanelContainer/MarginContainer/TabContainer/Player 1/ScrollContainer/MarginContainer/VBoxContainer/DAS"
@onready var p1SDF: HandlingManager = $"PanelContainer/MarginContainer/TabContainer/Player 1/ScrollContainer/MarginContainer/VBoxContainer/SDF"

@onready var p2MLButton: KeyBindsManager = $"PanelContainer/MarginContainer/TabContainer/Player 2/ScrollContainer/MarginContainer/VBoxContainer/MoveLeft/Button"
@onready var p2MRButton: KeyBindsManager = $"PanelContainer/MarginContainer/TabContainer/Player 2/ScrollContainer/MarginContainer/VBoxContainer/MoveRight/Button"
@onready var p2SDButton: KeyBindsManager = $"PanelContainer/MarginContainer/TabContainer/Player 2/ScrollContainer/MarginContainer/VBoxContainer/SoftDrop/Button"
@onready var p2HDButton: KeyBindsManager = $"PanelContainer/MarginContainer/TabContainer/Player 2/ScrollContainer/MarginContainer/VBoxContainer/HardDrop/Button"
@onready var p2CWButton: KeyBindsManager = $"PanelContainer/MarginContainer/TabContainer/Player 2/ScrollContainer/MarginContainer/VBoxContainer/ClockWise/Button"
@onready var p2CCWButton: KeyBindsManager = $"PanelContainer/MarginContainer/TabContainer/Player 2/ScrollContainer/MarginContainer/VBoxContainer/CounterClockWise/Button"
@onready var p2_180Button: KeyBindsManager = $"PanelContainer/MarginContainer/TabContainer/Player 2/ScrollContainer/MarginContainer/VBoxContainer/Rotate180/Button"
@onready var p2HoldButton: KeyBindsManager = $"PanelContainer/MarginContainer/TabContainer/Player 2/ScrollContainer/MarginContainer/VBoxContainer/Hold/Button"
@onready var p2ARR: HandlingManager = $"PanelContainer/MarginContainer/TabContainer/Player 2/ScrollContainer/MarginContainer/VBoxContainer/ARR"
@onready var p2DAS: HandlingManager = $"PanelContainer/MarginContainer/TabContainer/Player 2/ScrollContainer/MarginContainer/VBoxContainer/DAS"
@onready var p2SDF: HandlingManager = $"PanelContainer/MarginContainer/TabContainer/Player 2/ScrollContainer/MarginContainer/VBoxContainer/SDF"


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
	if player != 1:
		p2MLButton.UpdateKeybindDisplay()
		p2MRButton.UpdateKeybindDisplay()
		p2SDButton.UpdateKeybindDisplay()
		p2HDButton.UpdateKeybindDisplay()
		p2CWButton.UpdateKeybindDisplay()
		p2CCWButton.UpdateKeybindDisplay()
		p2_180Button.UpdateKeybindDisplay()
		p2HoldButton.UpdateKeybindDisplay()
		
func ResetHandling(player: int = 0):
	PlayerConfig.new().SetDefaultHandling(player)
	if(player != 2):
		p1ARR.UpdateSliderValue(Scripter.P1_ARR)
		p1DAS.UpdateSliderValue(Scripter.P1_DAS)
		p1SDF.UpdateSliderValue(Scripter.P1_SDF)
		print("Scripter ARR is: ", Scripter.P1_ARR, "And from the slider is: ", p1ARR.slider.value)
	if(player != 1):
		p2ARR.UpdateSliderValue(Scripter.P2_ARR)
		p2DAS.UpdateSliderValue(Scripter.P2_DAS)
		p2SDF.UpdateSliderValue(Scripter.P2_SDF)
		print("Scripter ARR is: ", Scripter.P2_ARR, "And from the slider is: ", p2ARR.slider.value)
		
		
func CheckForDuplicates():
	var key_map = {}
	var buttons = [p1MLButton, p1MRButton, p1SDButton, p1HDButton, p1CWButton, p1CCWButton, p1_180Button, p1HoldButton, p2MLButton, p2MRButton, p2SDButton, p2HDButton, p2CWButton, p2CCWButton, p2_180Button, p2HoldButton]
	
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
