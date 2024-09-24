class_name PlayerConfig extends Resource

@export var actionEvents: Dictionary = {}

const P1_MV_L : String = "P1_MV_L"
const P1_MV_R : String = "P1_MV_R"
const P1_HD : String = "P1_HD"
const P1_SD : String = "P1_SD"
const P1_CW : String = "P1_CW"
const P1_CCW : String = "P1_CCW"
const P1_180 : String = "P1_180"
const P1_HOLD : String = "P1_HOLD"

@export var Default_P1_MV_L = InputEventKey.new()
@export var Default_P1_MV_R = InputEventKey.new()
@export var Default_P1_HD = InputEventKey.new()
@export var Default_P1_SD = InputEventKey.new()
@export var Default_P1_CW = InputEventKey.new()
@export var Default_P1_CCW = InputEventKey.new()
@export var Default_P1_180 = InputEventKey.new()
@export var Default_P1_HOLD = InputEventKey.new()

var P1_MV_L_Key = InputEventKey.new()
var P1_MV_R_Key = InputEventKey.new()
var P1_HD_Key = InputEventKey.new()
var P1_SD_Key = InputEventKey.new()
var P1_CW_Key = InputEventKey.new()
var P1_CCW_Key = InputEventKey.new()
var P1_180_Key = InputEventKey.new()
var P1_HOLD_Key = InputEventKey.new()


var P1ARR
var P1DAS
var P1SDF

var P2ARR
var P2DAS
var P2SDF

func SaveNewSettings(arg: int = 0):
	var player1 = ConfigFile.new()
	var player2 = ConfigFile.new()
	
	if(arg != 2):
		player1.set_value("Controls", "MVL", InputMap.action_get_events("P1_MV_L"))
		player1.set_value("Controls", "MVR", InputMap.action_get_events("P1_MV_R"))
		player1.set_value("Controls", "SD", InputMap.action_get_events("P1_SD"))
		player1.set_value("Controls", "HD", InputMap.action_get_events("P1_HD"))
		player1.set_value("Controls", "CW", InputMap.action_get_events("P1_CW"))
		player1.set_value("Controls", "CCW", InputMap.action_get_events("P1_CCW"))
		player1.set_value("Controls", "180", InputMap.action_get_events("P1_180"))
		player1.set_value("Controls", "HOLD", InputMap.action_get_events("P1_HOLD"))
		
		player1.set_value("Handling", "ARR", P1ARR)
		player1.set_value("Handling", "DAS", P1DAS)
		player1.set_value("Handling", "SDF", P1SDF)
		
		player1.set_value("Customization", "Name", "Player 1")
		player1.set_value("Customization", "Skin", 0)
		player1.set_value("Customization", "Ghost", true)
		player1.set_value("Customization", "GhostColour", true)

		player1.save("user://player1.cfg")
		
	if(arg != 1):
		player2.set_value("Controls", "MVL", InputMap.action_get_events("P1_MV_L"))
		player2.set_value("Controls", "MVR", InputMap.action_get_events("P1_MV_R"))
		player2.set_value("Controls", "SD", InputMap.action_get_events("P1_SD"))
		player2.set_value("Controls", "HD", InputMap.action_get_events("P1_HD"))
		player2.set_value("Controls", "CW", InputMap.action_get_events("P1_CW"))
		player2.set_value("Controls", "CCW", InputMap.action_get_events("P1_CCW"))
		player2.set_value("Controls", "180", InputMap.action_get_events("P1_180"))
		player2.set_value("Controls", "HOLD", InputMap.action_get_events("P1_HOLD"))
		
		player2.set_value("Handling", "ARR", P2ARR)
		player2.set_value("Handling", "DAS", P2DAS)
		player2.set_value("Handling", "SDF", P2SDF)
		
		player2.set_value("Customization", "Name", "Player 2")
		player2.set_value("Customization", "Skin", 0)
		player2.set_value("Customization", "Ghost", true)
		player2.set_value("Customization", "GhostColour", true)

		player2.save("user://player2.cfg")


func SetDefaultSettings(arg: int = 0): #Make to only reset certain items in future
	var player1 = ConfigFile.new()
	var player2 = ConfigFile.new()
	
	if(arg != 2):
		player1.set_value("Controls", "MVL", InputMap.action_get_events("P1_MV_L"))
		player1.set_value("Controls", "MVR", InputMap.action_get_events("P1_MV_R"))
		player1.set_value("Controls", "SD", InputMap.action_get_events("P1_SD"))
		player1.set_value("Controls", "HD", InputMap.action_get_events("P1_HD"))
		player1.set_value("Controls", "CW", InputMap.action_get_events("P1_CW"))
		player1.set_value("Controls", "CCW", InputMap.action_get_events("P1_CCW"))
		player1.set_value("Controls", "180", InputMap.action_get_events("P1_180"))
		player1.set_value("Controls", "HOLD", InputMap.action_get_events("P1_HOLD"))
		
		player1.set_value("Handling", "ARR", 33)
		player1.set_value("Handling", "DAS", 167)
		player1.set_value("Handling", "SDF", 6)
		
		player1.set_value("Customization", "Name", "Player 1")
		player1.set_value("Customization", "Skin", 0)
		player1.set_value("Customization", "Ghost", true)
		player1.set_value("Customization", "GhostColour", true)

		player1.save("user://player1.cfg")
		
	if(arg != 1):
		player2.set_value("Controls", "MVL", InputMap.action_get_events("P1_MV_L"))
		player2.set_value("Controls", "MVR", InputMap.action_get_events("P1_MV_R"))
		player2.set_value("Controls", "SD", InputMap.action_get_events("P1_SD"))
		player2.set_value("Controls", "HD", InputMap.action_get_events("P1_HD"))
		player2.set_value("Controls", "CW", InputMap.action_get_events("P1_CW"))
		player2.set_value("Controls", "CCW", InputMap.action_get_events("P1_CCW"))
		player2.set_value("Controls", "180", InputMap.action_get_events("P1_180"))
		player2.set_value("Controls", "HOLD", InputMap.action_get_events("P1_HOLD"))
		
		player2.set_value("Handling", "ARR", 33)
		player2.set_value("Handling", "DAS", 167)
		player2.set_value("Handling", "SDF", 6)
		
		player2.set_value("Customization", "Name", "Player 2")
		player2.set_value("Customization", "Skin", 0)
		player2.set_value("Customization", "Ghost", true)
		player2.set_value("Customization", "GhostColour", true)

		player2.save("user://player2.cfg")
