class_name KeyBindsManager
extends Button

@export var player: int
@export var keybind: int
@onready var button: Button = $"."
@onready var rebindManager: RebindManager = $"../../../../../../../../../RebindHandler"
@onready var warning: ColorRect = $Warning
@onready var controlsManager: ControlsManager = $"../../../../../../../../.."


func _ready() -> void:
	await get_tree().process_frame
	UpdateKeybindDisplay()
	

func UpdateKeybindDisplay():
	button.text = Scripter.GetKeybindKey(GetAction())
	if controlsManager and is_instance_valid(controlsManager):
		controlsManager.CheckForDuplicates()



func ShowWarning(isEnabled: bool = true):
	warning.visible = isEnabled

func GetAction(getPlayer = player, getKeybind = keybind) -> String:
	var currentAction = "MV_L"
	var currentPlayer = "P1_"
	if(getPlayer == 0):
		currentPlayer = "P1_"
	else:
		currentPlayer = "P2_"
	match getKeybind:
		0:
			currentAction = "MV_L"
		1:
			currentAction = "MV_R"
		2:
			currentAction = "SD"
		3:
			currentAction = "HD"
		4:
			currentAction = "CW"
		5:
			currentAction = "CCW"
		6:
			currentAction = "180"
		7:
			currentAction = "HOLD"
	var currentRebind = currentPlayer + currentAction
	return currentRebind



func StartRebind() -> void:
	release_focus()
	rebindManager.visible = true
	rebindManager.StartRebind(GetAction(), self)
