class_name RebindManager
extends Control

var isRebinding: bool = false
var currentAction: String = "P1_MV_L"
var currentButton: KeyBindsManager

func StartRebind(newAction: String, newButton: KeyBindsManager):
	isRebinding = true
	currentAction = newAction
	currentButton = newButton
	pass

func _input(event: InputEvent) -> void:
	if isRebinding:
		if event is InputEventKey:
			InputMap.action_erase_events(currentAction)
			InputMap.action_add_event(currentAction, event)
			print("Rebind Complete")
			SyncButton()

func SyncButton():
	CancelRebind()
	currentButton.UpdateKeybindDisplay()
	currentButton.call_deferred("grab_focus")
	PlayerConfig.new().SaveNewSettings(1)
	
func CancelRebind():
	isRebinding = false
	visible = false
