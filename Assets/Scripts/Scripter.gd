class_name ScripterData
extends Node

static var instance: ScripterData

static var P1_Name: String = "ManuEcheveste"
static var P1_ARR: int = 0 #Automatic Repeat Rate
static var P1_DAS: int = 142 #Delayed Autoshift
static var P1_SDF: int = 41 #Soft Drop Factor
static var P1_Skin: int
static var P1_UseGhost: bool = true
static var P1_UseGhostColour: bool = true

var P2_Name: String = "Kei"
var P2_ARR: int = 0 #Automatic Repeat Rate
var P2_DAS: int = 140 #Delayed Autoshift
var P2_SDF: int = 40 #Soft Drop Factor
var P2_Skin: int
var P2_UseGhost: bool = true
var P2_UseGhostColour: bool = true

func _ready():
	instance = self
	PlayerConfig.new().LoadKeyBindsFromConfig()
	PlayerConfig.new().LoadHandlingFromConfig()
	if not DirAccess.dir_exists_absolute("user://skins"):
		DirAccess.make_dir_absolute("user://skins")
	#var config = PlayerConfig.new()
	#config.SetDefaultSettings()

func GetKeybindKey(action: String) -> String:
	var inputEvents = InputMap.action_get_events(action)
	var inputEvent = inputEvents[0]
	var inputKeyCode = OS.get_keycode_string(inputEvent.physical_keycode)
	#print(inputEvents)
	#print(inputEvent)
	#print(inputKeyCode)
	return(inputKeyCode)
