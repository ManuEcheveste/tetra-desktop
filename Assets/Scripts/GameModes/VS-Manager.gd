extends Control
@onready var P1_Animator = $Boards/Player1/Animator
@onready var P2_Animator = $Boards/Player2/Animator

var maxPoints: int = 7
var P1Points: int = 0
var P2Points: int = 0

var countDown: int = 5



# Called when the node enters the scene tree for the first time.
func PlayerOneDead():
	P1_Animator.play("Boards/Lose")
	P2_Animator.play("Boards/Win")
	P2Points += 1
	VerifyScore()

func PlayerTwoDead():
	P2_Animator.play("Boards/Lose")
	P1_Animator.play("Boards/Win")
	P1Points += 1
	VerifyScore()



func TopOutAnimFinished(anim_name):	
	pass # Replace with function body.

func ResetBoards():
	pass

func VerifyScore():
	if P1Points == maxPoints:
		pass
	elif P2Points == maxPoints:
		pass

func PlayerWin(player: int):
	if player == 1:
		print("Player 1 won")
	else:
		print("Player 2 won")
	get_tree().change_scene_to_file("res://Assets/Scenes/MainMenu.tscn")
