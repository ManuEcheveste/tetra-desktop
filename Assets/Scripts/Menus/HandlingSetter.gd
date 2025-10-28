class_name HandlingSetter
extends Control
@onready var title: Label = $PanelContainer/MarginContainer/VBoxContainer/Title
@onready var data: SpinBox = $PanelContainer/MarginContainer/VBoxContainer/Data
var handlingCaller: HandlingManager



func GetNewHandling(newTitle: String, minValue: int, maxValue: int, currentValue: int, newCaller: HandlingManager):
	title.text = newTitle
	data.min_value = minValue
	data.max_value = maxValue
	data.set_value_no_signal(currentValue)
	handlingCaller = newCaller

func ReturnNewHandling():
	handlingCaller.ReceiveNewValue(int(data.value))
	Cancel()
	
func Cancel():
	visible = false
