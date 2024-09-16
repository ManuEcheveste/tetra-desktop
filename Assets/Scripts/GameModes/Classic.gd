extends Control
@onready var BoardAnimator = $Boards/Player1/Animator

var currentLines: int = 0
# Called when the node enters the scene tree for the first time.
func VerifyLines(lines: int):
	currentLines += lines
	print("Lines are: ", currentLines)

func LostTheGame():
	BoardAnimator.play("Boards/Lose")
	


func _on_animator_animation_finished(anim_name):
	if anim_name == "Boards/Lose":
		get_tree().change_scene_to_file("res://Assets/Scenes/MainMenu.tscn")
		
