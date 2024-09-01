extends Control

var totalTime: float = 0
#Pieces
@onready var totalPiecesLabel = $"Pieces Label/Total Pieces"
@onready var ppsLabel = $"Pieces Label/PPS"
var totalPieces: int = 0
var pps: float = 0

#Attack
@onready var totalAttackLabel = $"Attack/Total Attack"
@onready var apmLabel = $Attack/APM
var totalAttack: int = 0
var apm: float = 0

@onready var vsScore = $"VS Label/VS Score"


func PlacedPiece():
	totalPieces += 1
	totalPiecesLabel.text = str(totalPieces, ",")
	
func Attack(lines: int):
	totalAttack += lines
	totalAttackLabel.text = str(totalAttack, ",")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	totalTime += delta
	
	
	if totalTime > 0:
		pps = RoundToDec(totalPieces / totalTime, 2)
	else:
		pps = 0
		
	var totalMinutes = totalTime / 60.0
	if totalMinutes > 0:
		apm = RoundToDec(totalAttack / totalMinutes, 2)
	else:
		apm = 0
		
	if pps == 0:
		ppsLabel.text = "0.00/s"
	else:
		ppsLabel.text = str(RoundToDec(pps, 2), "/s")
		
	if apm == 0:
		apmLabel.text = "0.00/m"
	else:
		apmLabel.text = str(RoundToDec(apm, 2), "/m")
	

func RoundToDec(num, digit):
	return round(num * pow(10.0,digit)) / pow(10.0,digit)
