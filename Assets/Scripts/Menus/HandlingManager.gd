extends HBoxContainer
@onready var slider: HSlider = $HSlider
@onready var displayButton: Button = $Button
@export var player: int = 0
@export var action: int = 0 #0 = ARR, 1 = DAS, 2 = SDF

func UpdateDisplay(newValue: float = 0):
	if action == 2 && newValue == 41:
		displayButton.text = "INF"
	else:
		displayButton.text = str(int(newValue))

func UpdateSliderValue(newValue: float):
	slider.value = newValue

func _ready():
	if player == 0:
		match action:
			0:
				UpdateSliderValue(Scripter.P1_ARR)
			1:
				UpdateSliderValue(Scripter.P1_DAS)
			2:
				UpdateSliderValue(Scripter.P1_SDF)
	else:
		match action:
			0:
				UpdateSliderValue(Scripter.P2_ARR)
			1:
				UpdateSliderValue(Scripter.P2_DAS)
			2:
				UpdateSliderValue(Scripter.P2_SDF)

func SaveNewValue(valueChanged: bool = false):
	if valueChanged:
		UpdateDisplay(slider.value)
		if player == 0:
			match action:
				0:
					Scripter.P1_ARR = int(slider.value)
				1:
					Scripter.P1_DAS = int(slider.value)
				2:
					Scripter.P1_SDF = int(slider.value)
		else:
			match action:
				0:
					Scripter.P2_ARR = int(slider.value)
				1:
					Scripter.P2_DAS = int(slider.value)
				2:
					Scripter.P2_SDF = int(slider.value)
		PlayerConfig.new().SaveNewSettings()
