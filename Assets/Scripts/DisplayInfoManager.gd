extends Control

var gameStarted: bool = false
var totalTime: float = 0
#Pieces
@onready var totalPiecesLabel = $PiecesLabel/Data/TotalPieces
@onready var ppsLabel = $PiecesLabel/Data/PPS
var totalPieces: int = 0
var pps: float = 0
#Attack
@onready var totalAttackLabel = $AttackLabel/Data/TotalAttack
@onready var apmLabel = $AttackLabel/Data/APM
var totalAttack: int = 0
var apm: float = 0

@onready var vsScoreLabel = $VSLabel/Data/ScoreINT
@onready var vsScoreDecimalsLabel = $VSLabel/Data/ScoreDecimals

@onready var timeLabel = $TimeLabel/Data/MainTime
@onready var timeMSLabel = $TimeLabel/Data/MS


var vsScore: float = 0

func _ready():
	StartGame()

func StartGame():
	gameStarted = true

func StopGame():
	gameStarted = false

func PlacedPiece():
	totalPieces += 1
	totalPiecesLabel.text = str(totalPieces, ",")
	
func Attack(lines: int):
	totalAttack += lines
	totalAttackLabel.text = str(totalAttack, ",")
# Called every frame. 'delta' is the elapsed time since the previous frame.

func _process(delta):
	if gameStarted:
		totalTime += delta
		
		@warning_ignore("integer_division")
		var mins: int = int(totalTime) / 60
		var secs: int = int(totalTime) % 60
		var ms: int = int((totalTime - int(totalTime)) * 1000)
		
		if totalTime > 0:
			pps = RoundToDec(totalPieces / totalTime, 2)
			timeLabel.text = str(mins) + ":" + str(secs).pad_zeros(2)
			timeMSLabel.text = str(".",ms).pad_zeros(3)
		else:
			pps = 0
			apm = 0
			timeLabel.text = "0:00"
			timeMSLabel.text = ".000"
			
			
		var totalMinutes = totalTime / 60.0
		if totalMinutes > 0:
			apm = RoundToDec(totalAttack / totalMinutes, 2)
		else:
			apm = 0
		
		if totalPieces != 0:
			var totalAttFloat: float = totalAttack
			var totalPpFloat: float = totalPieces
			vsScore = RoundToDec((totalAttFloat / totalPpFloat) * pps * 100, 2)
				
		if pps == 0:
			ppsLabel.text = "0.00/S"
		else:
			ppsLabel.text = str(RoundToDec(pps, 2), "/S").pad_decimals(2)
			
		if apm == 0:
			apmLabel.text = "0.00/M"
		else:
			apmLabel.text = str(RoundToDec(apm, 2), "/M").pad_decimals(2)
		
		if vsScore == 0:
			vsScoreLabel.text = "0"
			vsScoreDecimalsLabel.text = ".00"
		else:
			var vsINT: int = int(vsScore)
			var vsDEC: int = int(round((vsScore - vsINT)*100))
			vsScoreLabel.text = str(vsINT)
			vsScoreDecimalsLabel.text = str(".",vsDEC).pad_zeros(2)
	

func RoundToDec(num, digit):
	return round(num * pow(10.0,digit)) / pow(10.0,digit)
