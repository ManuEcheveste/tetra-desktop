extends Control
@onready var mainMenu = $MainMenu
@onready var playMenu = $PlayMenu
@onready var optionsMenu = $OptionsMenu




func ActivatePlayMenu():
	mainMenu.visible = false
	playMenu.visible = true
	

func ActivateOptionsMenu():
	mainMenu.visible = false
	optionsMenu.visible = true



func GoToVS():
	get_tree().change_scene_to_file("res://Assets/Scenes/GameModes/VS-Game.tscn")
	


func GoTo40Lines():
	get_tree().change_scene_to_file("res://Assets/Scenes/GameModes/40-Lines.tscn")


func BackPlay():
	mainMenu.visible = true
	playMenu.visible = false


func BackOptions():
	mainMenu.visible = true
	optionsMenu.visible = false


func GoToClassic():
	get_tree().change_scene_to_file("res://Assets/Scenes/GameModes/Classic.tscn")
