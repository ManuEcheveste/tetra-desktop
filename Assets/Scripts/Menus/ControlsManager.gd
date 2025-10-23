extends Control

var isRemaping = false;
var actionToRemap = null
var remapingButton = null
@onready var keyBindResource : PlayerConfig = preload("res://Prefabs/DefaultP1Keybinds.tres")




func CreatePlayer1Dictionary() -> Dictionary:
	var keyBindsContainerDictionary = {
		keyBindResource.P1_MV_L : keyBindResource.P1_MV_L_Key,
		keyBindResource.P1_MV_R : keyBindResource.P1_MV_R_Key,
		keyBindResource.P1_HD : keyBindResource.P1_HD_Key,
		keyBindResource.P1_SD : keyBindResource.P1_SD_Key,
		keyBindResource.P1_CW : keyBindResource.P1_CW_Key,
		keyBindResource.P1_CCW : keyBindResource.P1_CCW_Key,
		keyBindResource.P1_180 : keyBindResource.P1_180_Key,
		keyBindResource.P1_HOLD : keyBindResource.P1_HOLD_Key
	}
	
	return keyBindsContainerDictionary

func RebindAction(player: int, action: int):
	isRemaping = true
	var currentAction = "MV_L"
	var currentPlayer = "P1_"
	if(player == 0):
		currentPlayer = "P1_"
	else:
		currentPlayer = "P2_"
	match action:
		0:
			currentAction = "MV_L"
		1:
			currentAction = "MV_R"
		2:
			currentAction = "HD"
		3:
			currentAction = "SD"
		4:
			currentAction = "CW"
		5:
			currentAction = "CCW"
		6:
			currentAction = "180"
		7:
			currentAction = "HOLD"
	var currentRebind = currentPlayer + currentAction
	print(currentRebind)

func SaveP1DAS():
	
	pass
