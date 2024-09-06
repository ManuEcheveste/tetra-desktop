extends Control
@onready var BoardAnimator = $Boards/Player1/Animator
@onready var endScreen = $EndResults

signal WonGame
var currentLines: int = 0
var linesTarget: int = 40
# Called when the node enters the scene tree for the first time.
func VerifyLines(lines: int):
	currentLines += lines
	print("Lines are: ", currentLines)
	if currentLines >= linesTarget:
		WonTheGame()

func LostTheGame():
	BoardAnimator.play("Boards/Lose")
	

func _input(event):
	if event.is_action_pressed("ToggleFullScreen"):
		WonTheGame()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func WonTheGame():
	endScreen.visible = true
	BoardAnimator.play("Boards/Win")
	WonGame.emit()


func _on_animator_animation_finished(anim_name):
	if anim_name == "Boards/Lose":
		get_tree().change_scene_to_file("res://Assets/Scenes/MainMenu.tscn")
		
	pass # Replace with function body.
