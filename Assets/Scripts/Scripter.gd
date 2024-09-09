class_name ScripterData
extends Node

var P1_Name: String = "ManuEcheveste"
var P1_ARR: int = 0 #Automatic Repeat Rate
var P1_DAS: int = 142 #Delayed Autoshift
var P1_SDF: int = 41 #Soft Drop Factor
var P1_Skin: int
var P1_UseGhost: bool = true
var P1_UseGhostColour: bool = true

var P2_Name: String = "Kei"
var P2_ARR: int = 0 #Automatic Repeat Rate
var P2_DAS: int = 140 #Delayed Autoshift
var P2_SDF: int = 41 #Soft Drop Factor
var P2_Skin: int
var P2_UseGhost: bool = true
var P2_UseGhostColour: bool = true

func _ready():
	var config = PlayerConfig.new()
	#config.SetDefaultSettings()

func _input(event):
	if event.is_action_pressed("P2_HOLD"):
		InputMap.action_erase_events("ToggleFullScreen")
		print(InputMap.action_get_events("P2_HOLD"))
		pass
