class_name PlayerConfig extends Resource

@export var Default_P1_MV_L = InputEventKey.new()
@export var Default_P1_MV_R = InputEventKey.new()
@export var Default_P1_HD = InputEventKey.new()
@export var Default_P1_SD = InputEventKey.new()
@export var Default_P1_CW = InputEventKey.new()
@export var Default_P1_CCW = InputEventKey.new()
@export var Default_P1_180 = InputEventKey.new()
@export var Default_P1_HOLD = InputEventKey.new()

@export var Default_P2_MV_L = InputEventKey.new()
@export var Default_P2_MV_R = InputEventKey.new()
@export var Default_P2_HD = InputEventKey.new()
@export var Default_P2_SD = InputEventKey.new()
@export var Default_P2_CW = InputEventKey.new()
@export var Default_P2_CCW = InputEventKey.new()
@export var Default_P2_180 = InputEventKey.new()
@export var Default_P2_HOLD = InputEventKey.new()



func LoadKeyBindsFromConfig(player: int = 0):
	if player != 2:
		if FileAccess.file_exists("user://player1.cfg"):
			var player1 = ConfigFile.new()
			player1.load("user://player1.cfg")
			InputMap.action_erase_events("P1_MV_L")
			InputMap.action_add_event("P1_MV_L", player1.get_value("Controls", "MVL"))
			InputMap.action_erase_events("P1_MV_R")
			InputMap.action_add_event("P1_MV_R", player1.get_value("Controls", "MVR"))
			InputMap.action_erase_events("P1_SD")
			InputMap.action_add_event("P1_SD", player1.get_value("Controls", "SD"))
			InputMap.action_erase_events("P1_HD")
			InputMap.action_add_event("P1_HD", player1.get_value("Controls", "HD"))
			InputMap.action_erase_events("P1_CW")
			InputMap.action_add_event("P1_CW", player1.get_value("Controls", "CW"))
			InputMap.action_erase_events("P1_CCW")
			InputMap.action_add_event("P1_CCW", player1.get_value("Controls", "CCW"))
			InputMap.action_erase_events("P1_180")
			InputMap.action_add_event("P1_180", player1.get_value("Controls", "180"))
			InputMap.action_erase_events("P1_HOLD")
			InputMap.action_add_event("P1_HOLD", player1.get_value("Controls", "HOLD"))
	if player != 1:
		if FileAccess.file_exists("user://player2.cfg"):
			var player2 = ConfigFile.new()
			player2.load("user://player2.cfg")
			InputMap.action_erase_events("P2_MV_L")
			InputMap.action_add_event("P2_MV_L", player2.get_value("Controls", "MVL"))
			InputMap.action_erase_events("P2_MV_R")
			InputMap.action_add_event("P2_MV_R", player2.get_value("Controls", "MVR"))
			InputMap.action_erase_events("P2_SD")
			InputMap.action_add_event("P2_SD", player2.get_value("Controls", "SD"))
			InputMap.action_erase_events("P2_HD")
			InputMap.action_add_event("P2_HD", player2.get_value("Controls", "HD"))
			InputMap.action_erase_events("P2_CW")
			InputMap.action_add_event("P2_CW", player2.get_value("Controls", "CW"))
			InputMap.action_erase_events("P2_CCW")
			InputMap.action_add_event("P2_CCW", player2.get_value("Controls", "CCW"))
			InputMap.action_erase_events("P2_180")
			InputMap.action_add_event("P2_180", player2.get_value("Controls", "180"))
			InputMap.action_erase_events("P2_HOLD")
			InputMap.action_add_event("P2_HOLD", player2.get_value("Controls", "HOLD"))



func SaveNewSettings(arg: int = 0):
	var player1 = ConfigFile.new()
	var player2 = ConfigFile.new()
	
	if(arg != 2):
		player1.set_value("Controls", "MVL", InputMap.action_get_events("P1_MV_L")[0])
		player1.set_value("Controls", "MVR", InputMap.action_get_events("P1_MV_R")[0])
		player1.set_value("Controls", "SD", InputMap.action_get_events("P1_SD")[0])
		player1.set_value("Controls", "HD", InputMap.action_get_events("P1_HD")[0])
		player1.set_value("Controls", "CW", InputMap.action_get_events("P1_CW")[0])
		player1.set_value("Controls", "CCW", InputMap.action_get_events("P1_CCW")[0])
		player1.set_value("Controls", "180", InputMap.action_get_events("P1_180")[0])
		player1.set_value("Controls", "HOLD", InputMap.action_get_events("P1_HOLD")[0])
		
		player1.set_value("Handling", "ARR", Scripter.P1_ARR)
		player1.set_value("Handling", "DAS", Scripter.P1_DAS)
		player1.set_value("Handling", "SDF", Scripter.P1_SDF)
		
		player1.set_value("Customization", "Name", Scripter.P1_Name)
		player1.set_value("Customization", "Skin", Scripter.P1_Skin)
		player1.set_value("Customization", "Ghost", Scripter.P1_UseGhost)
		player1.set_value("Customization", "GhostColour", Scripter.P1_UseGhostColour)
		
		player1.save("user://player1.cfg")
		
	if(arg != 1):
		player2.set_value("Controls", "MVL", InputMap.action_get_events("P2_MV_L")[0])
		player2.set_value("Controls", "MVR", InputMap.action_get_events("P2_MV_R")[0])
		player2.set_value("Controls", "SD", InputMap.action_get_events("P2_SD")[0])
		player2.set_value("Controls", "HD", InputMap.action_get_events("P2_HD")[0])
		player2.set_value("Controls", "CW", InputMap.action_get_events("P2_CW")[0])
		player2.set_value("Controls", "CCW", InputMap.action_get_events("P2_CCW")[0])
		player2.set_value("Controls", "180", InputMap.action_get_events("P2_180")[0])
		player2.set_value("Controls", "HOLD", InputMap.action_get_events("P2_HOLD")[0])
		
		player2.set_value("Handling", "ARR", Scripter.P2_ARR)
		player2.set_value("Handling", "DAS", Scripter.P2_DAS)
		player2.set_value("Handling", "SDF", Scripter.P2_SDF)
		
		player2.set_value("Customization", "Name", Scripter.P2_Name)
		player2.set_value("Customization", "Skin", Scripter.P2_Skin)
		player2.set_value("Customization", "Ghost", Scripter.P2_UseGhost)
		player2.set_value("Customization", "GhostColour", Scripter.P2_UseGhostColour)
		
		player2.save("user://player2.cfg")
pass

func SetDefaultSettings(player: int = 0): #Make to only reset certain items in future
	var player1 = ConfigFile.new()
	var player2 = ConfigFile.new()
	if player != 2:
		SetDefaultKeybinds(1)
		player1.set_value("Controls", "MVL", InputMap.action_get_events("P1_MV_L")[0])
		player1.set_value("Controls", "MVR", InputMap.action_get_events("P1_MV_R")[0])
		player1.set_value("Controls", "SD", InputMap.action_get_events("P1_SD")[0])
		player1.set_value("Controls", "HD", InputMap.action_get_events("P1_HD")[0])
		player1.set_value("Controls", "CW", InputMap.action_get_events("P1_CW")[0])
		player1.set_value("Controls", "CCW", InputMap.action_get_events("P1_CCW")[0])
		player1.set_value("Controls", "180", InputMap.action_get_events("P1_180")[0])
		player1.set_value("Controls", "HOLD", InputMap.action_get_events("P1_HOLD")[0])
		
		player1.set_value("Handling", "ARR", 33)
		player1.set_value("Handling", "DAS", 167)
		player1.set_value("Handling", "SDF", 6)
		
		player1.set_value("Customization", "Name", "Player 1")
		player1.set_value("Customization", "Skin", 0)
		player1.set_value("Customization", "Ghost", true)
		player1.set_value("Customization", "GhostColour", true)
		
		player1.save("user://player1.cfg")
		
	if player != 1:
		SetDefaultKeybinds(2)
		player2.set_value("Controls", "MVL", InputMap.action_get_events("P2_MV_L")[0])
		player2.set_value("Controls", "MVR", InputMap.action_get_events("P2_MV_R")[0])
		player2.set_value("Controls", "SD", InputMap.action_get_events("P2_SD")[0])
		player2.set_value("Controls", "HD", InputMap.action_get_events("P2_HD")[0])
		player2.set_value("Controls", "CW", InputMap.action_get_events("P2_CW")[0])
		player2.set_value("Controls", "CCW", InputMap.action_get_events("P2_CCW")[0])
		player2.set_value("Controls", "180", InputMap.action_get_events("P2_180")[0])
		player2.set_value("Controls", "HOLD", InputMap.action_get_events("P2_HOLD")[0])
		
		player2.set_value("Handling", "ARR", 33)
		player2.set_value("Handling", "DAS", 167)
		player2.set_value("Handling", "SDF", 6)
		
		player2.set_value("Customization", "Name", "Player 2")
		player2.set_value("Customization", "Skin", 0)
		player2.set_value("Customization", "Ghost", true)
		player2.set_value("Customization", "GhostColour", true)
		
		player2.save("user://player2.cfg")
pass


func SetDefaultKeybinds(player: int = 0):
	var defaultConfig = load("res://Prefabs/DefaultPlayerKeybinds.tres")
	if player != 2:
		InputMap.action_erase_events("P1_MV_L")
		InputMap.action_add_event("P1_MV_L", defaultConfig.Default_P1_MV_L)
		InputMap.action_erase_events("P1_MV_R")
		InputMap.action_add_event("P1_MV_R", defaultConfig.Default_P1_MV_R)
		InputMap.action_erase_events("P1_SD")
		InputMap.action_add_event("P1_SD", defaultConfig.Default_P1_SD)
		InputMap.action_erase_events("P1_HD")
		InputMap.action_add_event("P1_HD", defaultConfig.Default_P1_HD)
		InputMap.action_erase_events("P1_CW")
		InputMap.action_add_event("P1_CW", defaultConfig.Default_P1_CW)
		InputMap.action_erase_events("P1_CCW")
		InputMap.action_add_event("P1_CCW", defaultConfig.Default_P1_CCW)
		InputMap.action_erase_events("P1_180")
		InputMap.action_add_event("P1_180", defaultConfig.Default_P1_180)
		InputMap.action_erase_events("P1_HOLD")
		InputMap.action_add_event("P1_HOLD", defaultConfig.Default_P1_HOLD)
		SaveNewSettings(1)
	if player != 1:
		InputMap.action_erase_events("P2_MV_L")
		InputMap.action_add_event("P2_MV_L", defaultConfig.Default_P2_MV_L)
		InputMap.action_erase_events("P2_MV_R")
		InputMap.action_add_event("P2_MV_R", defaultConfig.Default_P2_MV_R)
		InputMap.action_erase_events("P2_SD")
		InputMap.action_add_event("P2_SD", defaultConfig.Default_P2_SD)
		InputMap.action_erase_events("P2_HD")
		InputMap.action_add_event("P2_HD", defaultConfig.Default_P2_HD)
		InputMap.action_erase_events("P2_CW")
		InputMap.action_add_event("P2_CW", defaultConfig.Default_P2_CW)
		InputMap.action_erase_events("P2_CCW")
		InputMap.action_add_event("P2_CCW", defaultConfig.Default_P2_CCW)
		InputMap.action_erase_events("P2_180")
		InputMap.action_add_event("P2_180", defaultConfig.Default_P2_180)
		InputMap.action_erase_events("P2_HOLD")
		InputMap.action_add_event("P2_HOLD", defaultConfig.Default_P2_HOLD)
		SaveNewSettings(2)

func SetDefaultHandling(player: int):
	if (player != 2):
		Scripter.P1_ARR = 33
		Scripter.P1_DAS = 167
		Scripter.P1_SDF = 6
		SaveNewSettings(1)
	if (player != 1):
		Scripter.P2_ARR = 33
		Scripter.P2_DAS = 167
		Scripter.P2_SDF = 6
		SaveNewSettings(2)


func LoadHandlingFromConfig(player: int = 0):
	if player != 2:
		if FileAccess.file_exists("user://player1.cfg"):
			var player1 = ConfigFile.new()
			player1.load("user://player1.cfg")
			Scripter.P1_ARR = player1.get_value("Handling", "ARR")
			Scripter.P1_DAS = player1.get_value("Handling", "DAS")
			Scripter.P1_SDF = player1.get_value("Handling", "SDF")
	if player != 1:
		if FileAccess.file_exists("user://player2.cfg"):
			var player2 = ConfigFile.new()
			player2.load("user://player2.cfg")
			Scripter.P2_ARR = player2.get_value("Handling", "ARR")
			Scripter.P2_DAS = player2.get_value("Handling", "DAS")
			Scripter.P2_SDF = player2.get_value("Handling", "SDF")
	
