extends Button

@export var player: int
@export var keybind: int
@onready var button: Button = $"."

func _ready() -> void:
	UpdateKeybindDisplay()

func UpdateKeybindDisplay():
	var currentAction = "MV_L"
	var currentPlayer = "P1_"
	if(player == 0):
		currentPlayer = "P1_"
	else:
		currentPlayer = "P2_"
	match keybind:
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
	button.text = Scripter.GetKeybindKey(currentRebind)
	pass
