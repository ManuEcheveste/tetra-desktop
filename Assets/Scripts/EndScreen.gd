extends Control

signal AskForTime
@onready var timeLabel = $TimeData/MainTime
@onready var timeMSLabel = $TimeData/MS

var totalTime: float

# Called when the node enters the scene tree for the first time.
func GetResults():
	AskForTime.emit()
	
		
func UpdateResults(time: float):
	totalTime = time
	var mins: int = int(totalTime) / 60
	var secs: int = int(totalTime) % 60
	var ms: int = int((totalTime - int(totalTime)) * 1000)
	
	if totalTime > 0:
		timeLabel.text = str(mins) + ":" + str(secs).pad_zeros(2)
		timeMSLabel.text = str(".",ms).pad_zeros(3)
	


func GoToMain():
	get_tree().change_scene_to_file("res://Assets/Scenes/MainMenu.tscn")
