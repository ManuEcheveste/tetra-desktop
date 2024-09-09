class_name PlayerConfig extends Resource

@export var actionEvents: Dictionary = {}
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
		
		player2.set_value("Customization", "Name", "Player 1")
		player2.set_value("Customization", "Skin", 0)
		player2.set_value("Customization", "Ghost", true)
		player2.set_value("Customization", "GhostColour", true)

		player2.save("user://player2.cfg")
