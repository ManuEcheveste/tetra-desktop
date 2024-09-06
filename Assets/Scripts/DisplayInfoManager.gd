extends Control

var gameStarted: bool = false
var totalTime: float = 0
var hasGarbageMeter: bool = true

#region Pieces
@onready var totalPiecesLabel = $LeftSide/Elements/PiecesLabel/Data/TotalPieces
@onready var ppsLabel = $LeftSide/Elements/PiecesLabel/Data/PPS
var totalPieces: int = 0
var pps: float = 0
#endregion

#region Lines
@onready var linesCompletedLabel = $RightSide/Elements/Lines/Data/LinesCompleted
@onready var linesGoalLabel = $RightSide/Elements/Lines/Data/LinesGoal
var totalLines: int = 0

#region Attack
@onready var totalAttackLabel = $LeftSide/Elements/AttackLabel/Data/TotalAttack
@onready var apmLabel = $LeftSide/Elements/AttackLabel/Data/APM
var totalAttack: int = 0
var apm: float = 0
#endregion

#region VS Score
@onready var vsScoreLabel = $RightSide/Elements/VSLabel/Data/ScoreINT
@onready var vsScoreDecimalsLabel = $RightSide/Elements/VSLabel/Data/ScoreDecimals
#endregion

#region Time Clock
@onready var timeLabel = $LeftSide/Elements/TimeLabel/Data/MainTime
@onready var timeMSLabel = $LeftSide/Elements/TimeLabel/Data/MS
signal time(sentTime: float)
#endregion

#region Combo and clears
@onready var lineClearLabel = $Leyends/LineClear
@onready var b2bValueLabel = $Leyends/B2BCombo/Value
@onready var comboValueLabel = $Leyends/Combo/Value

#region Animators
@onready var tspinLabelAimator = $Leyends/TSpin/Animator
@onready var lineClearLabelAnimator = $Leyends/LineClear/Animator
@onready var b2bComboLabelAnimator = $Leyends/B2BCombo/Animator
@onready var comboLabelAnimator = $Leyends/Combo/Animator

#endregion

#endregion

@onready var garbageMeter = $LeftSide/GarbageMeter/GarbageBar

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

func UpdateGarbageMetter(garbage: int):
	garbageMeter.value = garbage

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
			ppsLabel.text = str(RoundToDec(pps, 2), "/S")
			
		if apm == 0:
			apmLabel.text = "0.00/M"
		else:
			apmLabel.text = str(RoundToDec(apm, 2), "/M")
		
		if vsScore == 0:
			vsScoreLabel.text = "0"
			vsScoreDecimalsLabel.text = ".00"
		else:
			var vsINT: int = int(vsScore)
			var vsDEC: int = int(round((vsScore - vsINT)*100))
			vsScoreLabel.text = str(vsINT)
			vsScoreDecimalsLabel.text = str(".",vsDEC).pad_zeros(2)



func ShowLinesLeyend(lines):
	match lines:
		1:
			lineClearLabel.text = "SINGLE"
		2:
			lineClearLabel.text = "DOUBLE"
		3:
			lineClearLabel.text = "TRIPLE"
		4:
			lineClearLabel.text = "TETRA"
	if lines != 0:
		lineClearLabelAnimator.stop()
		lineClearLabelAnimator.play("FadeOut")
	totalLines += lines
	linesCompletedLabel.text = str(totalLines)

func ShowTSpinLeyend():
	tspinLabelAimator.stop()
	tspinLabelAimator.play("FadeOut")

func ShowComboLeyend(combo: int):
	comboValueLabel.text = str(combo)
	comboLabelAnimator.stop()
	comboLabelAnimator.play("FadeOut")

func ShowB2BComboLeyend(combo: int):
	b2bValueLabel.text = str(combo)
	if combo != 0:
		b2bComboLabelAnimator.stop()
		b2bComboLabelAnimator.play("FadeOut")

func RoundToDec(num, digit):
	return round(num * pow(10.0,digit)) / pow(10.0,digit)

func SendTime():
	time.emit(totalTime)
	
