extends Control

var isRemaping = false;
var actionToRemap = null
var remapingButton = null
@onready var keyBindResource : PlayerConfig = preload("res://Prefabs/DefaultKeybinds.tres")


func CreateStorageDictionary() -> Dictionary:
	var settingsDictionary : Dictionary = {
		"P1Controls" : CreatePlayer1Dictionary()
	}
	return settingsDictionary

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

func SaveP1DAS():
	
	pass
