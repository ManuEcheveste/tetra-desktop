extends Control


#Pieces
@onready var totalPiecesLabel = $"Pieces Label/Total Pieces"
@onready var ppsLabel = $"Pieces Label/PPS"
var totalPieces: int = 0
var pps: float = 0
var ppsTime: float = 0

#Attack
@onready var totalAttack = $"Attack/Total Attack"
@onready var apm = $Attack/APM

@onready var vsScore = $"VS Label/VS Score"


func PlacedPiece():
	totalPieces += 1
	totalPiecesLabel.text = str(totalPieces)
	if ppsTime > 0:
		pps = RoundToDec(1 / ppsTime, 2)
	else:
		pps = 0
	ppsTime = 0
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	ppsTime += delta
	
	if ppsTime > 0:
		pps = totalPieces / ppsTime
	else:
		pps = 0
	
	ppsLabel.text = str(RoundToDec(pps, 2))
	

func RoundToDec(num, digit):
	return round(num * pow(10.0,digit)) / pow(10.0,digit)
