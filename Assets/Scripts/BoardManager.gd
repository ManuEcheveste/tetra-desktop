extends Control

@export var isPlayerOne:bool
var gameActive: bool = true #will change later to be false default
var isDebug = false
@onready var mainGrid = $MainGrid
@onready var activeGrid = $MainGrid/ActiveGrid
@onready var ghostGrid = $MainGrid/GhostGrid
@onready var dangerGrid = $MainGrid/DangerGrid
@onready var holdManager = $DisplayInfo/LeftSide/Elements/Hold/HoldGrid
@onready var queueManager = $DisplayInfo/RightSide/Elements/Queue/QueueDisplayManager

@onready var nameLabel = $DisplayInfo/NameLabel


#region Signals

signal LockedPiece
signal Attack(lines: int)
signal Lines(lines: int)
signal Combo(combo: int)
signal B2B
signal B2BCombo(combo: int)
signal TopedOut
signal Garbage(lines: int)
signal GamePaused(paused: bool)
#endregion


#region Audio
var audioPlayer= preload("res://Prefabs/AudioPlayer.tscn")

#region Movement/Input
var sfxRotate = preload("res://Assets/Audio/SFX/Rotate.wav")
var sfxMove = preload("res://Assets/Audio/SFX/Move.wav")
var sfxSoftDrop = preload("res://Assets/Audio/SFX/SoftDrop.wav")
var sfxHardDrop = preload("res://Assets/Audio/SFX/HardDrop.wav")
var sfxLockPiece = preload("res://Assets/Audio/SFX/LockPiece.wav")
var sfxHitFloor = preload("res://Assets/Audio/SFX/HitFloor.wav")
var sfxHold = preload("res://Assets/Audio/SFX/Hold.wav")
#endregion

var sfxPC = preload("res://Assets/Audio/SFX/PerfectClear.wav")
var sfxClearLine = preload("res://Assets/Audio/SFX/LineClear.wav")
var sfxClearTetra = preload("res://Assets/Audio/SFX/TetraClear.wav")

#region Combos
var sfxComboBreak = preload("res://Assets/Audio/SFX/Combo/ComboBreak.wav")

var sfxCombo1 = preload("res://Assets/Audio/SFX/Combo/Combo1.wav")
var sfxCombo2 = preload("res://Assets/Audio/SFX/Combo/Combo2.wav")
var sfxCombo3 = preload("res://Assets/Audio/SFX/Combo/Combo3.wav")
var sfxCombo4 = preload("res://Assets/Audio/SFX/Combo/Combo4.wav")
var sfxCombo5 = preload("res://Assets/Audio/SFX/Combo/Combo5.wav")
var sfxCombo6 = preload("res://Assets/Audio/SFX/Combo/Combo6.wav")
var sfxCombo7 = preload("res://Assets/Audio/SFX/Combo/Combo7.wav")
var sfxCombo8 = preload("res://Assets/Audio/SFX/Combo/Combo8.wav")
var sfxCombo9 = preload("res://Assets/Audio/SFX/Combo/Combo9.wav")
var sfxCombo10 = preload("res://Assets/Audio/SFX/Combo/Combo10.wav")
var sfxCombo11 = preload("res://Assets/Audio/SFX/Combo/Combo11.wav")
var sfxCombo12 = preload("res://Assets/Audio/SFX/Combo/Combo12.wav")
var sfxCombo13 = preload("res://Assets/Audio/SFX/Combo/Combo13.wav")
var sfxCombo14 = preload("res://Assets/Audio/SFX/Combo/Combo14.wav")
var sfxCombo15 = preload("res://Assets/Audio/SFX/Combo/Combo15.wav")
var sfxCombo16 = preload("res://Assets/Audio/SFX/Combo/Combo16.wav")

#endregion

#region BackToBack
var sfxSpin = preload("res://Assets/Audio/SFX/Spin.wav")
var sfxClearSpin = preload("res://Assets/Audio/SFX/ClearSpin.wav")
var sfxClearB2B = preload("res://Assets/Audio/SFX/ClearB2B.wav")

var sfxB2BBreak = preload("res://Assets/Audio/SFX/B2B/B2B-Break.wav")
var sfxB2BCombo1 = preload("res://Assets/Audio/SFX/B2B/B2B-Combo1.wav")
var sfxB2BCombo2 = preload("res://Assets/Audio/SFX/B2B/B2B-Combo2.wav")
var sfxB2BCombo3 = preload("res://Assets/Audio/SFX/B2B/B2B-Combo3.wav")
#endregion

var sfxTopOut = preload("res://Assets/Audio/SFX/TopOut.wav")
#endregion


#region Tetrominos
var I_0 := [Vector2i(0, 1), Vector2i(1, 1), Vector2i(2, 1), Vector2i(3, 1)]
var I_1 := [Vector2i(2, 0), Vector2i(2, 1), Vector2i(2, 2), Vector2i(2, 3)]
var I_2 := [Vector2i(0, 2), Vector2i(1, 2), Vector2i(2, 2), Vector2i(3, 2)]
var I_3 := [Vector2i(1, 0), Vector2i(1, 1), Vector2i(1, 2), Vector2i(1, 3)]
var I := [I_0, I_1, I_2, I_3]

var J_0 := [Vector2i(0, 0), Vector2i(0, 1), Vector2i(1, 1), Vector2i(2, 1)]
var J_1 := [Vector2i(1, 0), Vector2i(2, 0), Vector2i(1, 1), Vector2i(1, 2)]
var J_2 := [Vector2i(0, 1), Vector2i(1, 1), Vector2i(2, 1), Vector2i(2, 2)]
var J_3 := [Vector2i(1, 0), Vector2i(1, 1), Vector2i(0, 2), Vector2i(1, 2)]
var J := [J_0, J_1, J_2, J_3]

var L_0 := [Vector2i(2, 0), Vector2i(0, 1), Vector2i(1, 1), Vector2i(2, 1)]
var L_1 := [Vector2i(1, 0), Vector2i(1, 1), Vector2i(1, 2), Vector2i(2, 2)]
var L_2 := [Vector2i(0, 1), Vector2i(1, 1), Vector2i(2, 1), Vector2i(0, 2)]
var L_3 := [Vector2i(0, 0), Vector2i(1, 0), Vector2i(1, 1), Vector2i(1, 2)]
var L := [L_0, L_1, L_2, L_3]

var O_0 := [Vector2i(0, 0), Vector2i(1, 0), Vector2i(0, 1), Vector2i(1, 1)]
var O_1 := [Vector2i(0, 0), Vector2i(1, 0), Vector2i(0, 1), Vector2i(1, 1)]
var O_2 := [Vector2i(0, 0), Vector2i(1, 0), Vector2i(0, 1), Vector2i(1, 1)]
var O_3 := [Vector2i(0, 0), Vector2i(1, 0), Vector2i(0, 1), Vector2i(1, 1)]
var O := [O_0, O_1, O_2, O_3]

var T_0 := [Vector2i(1, 0), Vector2i(0, 1), Vector2i(1, 1), Vector2i(2, 1)]
var T_1 := [Vector2i(1, 0), Vector2i(1, 1), Vector2i(2, 1), Vector2i(1, 2)]
var T_2 := [Vector2i(0, 1), Vector2i(1, 1), Vector2i(2, 1), Vector2i(1, 2)]
var T_3 := [Vector2i(1, 0), Vector2i(0, 1), Vector2i(1, 1), Vector2i(1, 2)]
var T := [T_0, T_1, T_2, T_3]

var S_0 := [Vector2i(1, 0), Vector2i(2, 0), Vector2i(0, 1), Vector2i(1, 1)]
var S_1 := [Vector2i(1, 0), Vector2i(1, 1), Vector2i(2, 1), Vector2i(2, 2)]
var S_2 := [Vector2i(1, 1), Vector2i(2, 1), Vector2i(0, 2), Vector2i(1, 2)]
var S_3 := [Vector2i(0, 0), Vector2i(0, 1), Vector2i(1, 1), Vector2i(1, 2)]
var S := [S_0, S_1, S_2, S_3]

var Z_0 := [Vector2i(0, 0), Vector2i(1, 0), Vector2i(1, 1), Vector2i(2, 1)]
var Z_1 := [Vector2i(2, 0), Vector2i(1, 1), Vector2i(2, 1), Vector2i(1, 2)]
var Z_2 := [Vector2i(0, 1), Vector2i(1, 1), Vector2i(1, 2), Vector2i(2, 2)]
var Z_3 := [Vector2i(1, 0), Vector2i(0, 1), Vector2i(1, 1), Vector2i(0, 2)]
var Z := [Z_0, Z_1, Z_2, Z_3]

var N_0 := [Vector2i(-1000, 0), Vector2i(-1000, 0), Vector2i(-1000, 0), Vector2i(-1000, 0)]
var N_1 := [Vector2i(-1000, 0), Vector2i(-1000, 0), Vector2i(-1000, 0), Vector2i(-1000, 0)]
var N_2 := [Vector2i(-1000, 0), Vector2i(-1000, 0), Vector2i(-1000, 0), Vector2i(-1000, 0)]
var N_3 := [Vector2i(-1100, 0), Vector2i(-1000, 0), Vector2i(-1000, 0), Vector2i(-1000, 0)]
var N := [N_0, N_1, N_2, N_3]


#region KickTable
var kickTable := {
	"0-1": [Vector2i(0, 0), Vector2i(-1, 0), Vector2i(-1, -1), Vector2i(0, 2), Vector2i(-1, 2)],
	"1-0": [Vector2i(0, 0), Vector2i(1, 0), Vector2i(1, 1), Vector2i(0, -2), Vector2i(1, -2)],
	"1-2": [Vector2i(0, 0), Vector2i(1, 0), Vector2i(1, 1), Vector2i(0, -2), Vector2i(1, -2)],
	"2-1": [Vector2i(0, 0), Vector2i(-1, 0), Vector2i(-1, -1), Vector2i(0, 2), Vector2i(-1, 2)],
	"2-3": [Vector2i(0, 0), Vector2i(1, 0), Vector2i(1, -1), Vector2i(0, 2), Vector2i(1, 2)],
	"3-2": [Vector2i(0, 0), Vector2i(-1, 0), Vector2i(-1, 1), Vector2i(0, -2), Vector2i(-1, -2)],
	"3-0": [Vector2i(0, 0), Vector2i(-1, 0), Vector2i(-1, 1), Vector2i(0, -2), Vector2i(-1, -2)],
	"0-3": [Vector2i(0, 0), Vector2i(1, 0), Vector2i(1, -1), Vector2i(0, 2), Vector2i(1, 2)],
	"0-2": [Vector2i(0, 0), Vector2i(0, -1), Vector2i(1, -1), Vector2i(-1, -1), Vector2i(1, 0)],
	"1-3": [Vector2i(0, 0), Vector2i(1, 0), Vector2i(1, -2), Vector2i(1, -1), Vector2i(0, -2)],
	"2-0": [Vector2i(0, 0), Vector2i(0, 1), Vector2i(-1, 1), Vector2i(1, 1), Vector2i(-1, 0)],
	"3-1": [Vector2i(0, 0), Vector2i(-1, 0), Vector2i(-1, -2), Vector2i(-1, -1), Vector2i(0, -2)]
}

var kickTableI := {
	"0-1": [Vector2i(0, 0), Vector2i(1, 0), Vector2i(-2, 0), Vector2i(-2, 1), Vector2i(1, -2)],
	"1-0": [Vector2i(0, 0), Vector2i(-1, 0), Vector2i(2, 0), Vector2i(1, 2), Vector2i(2, -1)],
	"1-2": [Vector2i(0, 0), Vector2i(-1, 0), Vector2i(2, 0), Vector2i(-1, -2), Vector2i(2, 1)],
	"2-1": [Vector2i(0, 0), Vector2i(-2, 0), Vector2i(1, 0), Vector2i(-2, -1), Vector2i(1, 2)],
	"2-3": [Vector2i(0, 0), Vector2i(2, 0), Vector2i(-1, 0), Vector2i(2, -1), Vector2i(-1, 2)],
	"3-2": [Vector2i(0, 0), Vector2i(1, 0), Vector2i(-2, 0), Vector2i(1, -2), Vector2i(-2, 1)],
	"3-0": [Vector2i(0, 0), Vector2i(1, 0), Vector2i(-2, 0), Vector2i(1, 2), Vector2i(-2, -1)],
	"0-3": [Vector2i(0, 0), Vector2i(-1, 0), Vector2i(2, 0), Vector2i(2, 1), Vector2i(-1, -2)],
	"0-2": [Vector2i(0, 0), Vector2i(0, -1), Vector2i(1, -1), Vector2i(-1, -1), Vector2i(1, 0)],
	"1-3": [Vector2i(0, 0), Vector2i(1, 0), Vector2i(1, -2), Vector2i(1, -1), Vector2i(0, -2)],
	"2-0": [Vector2i(0, 0), Vector2i(0, 1), Vector2i(-1, 1), Vector2i(1, 1), Vector2i(-1, 0)],
	"3-1": [Vector2i(0, 0), Vector2i(-1, 0), Vector2i(-1, -2), Vector2i(-1, -1), Vector2i(0, -2)]
}
#endregion

var bag := [I, J, L, O, T, S, Z]
var currentBag := bag.duplicate()
#endregion

var playerName: String


#Attack/combos
var inCombo: bool = false
var combo: int = 0
var inB2B: bool = false
var b2b: int = 0
var pendingGarbage: Array = []




#T-Spin related Calcs
var lastActRotation: bool = false
var tSpinType: int = 0


#Current Piece, AKA Active piece
var currentPiece: String
var currentPieceTiles = N[0]
var currentPieceCoords: Vector2i
var currentPieceRotation: int = 0

#Ghost Pieces
var useGhost = Scripter.P1_UseGhost
var useGhostColour = Scripter.P1_UseGhostColour

#Board variables/settings
var boardWidth: int = 10
var boardHeight: int = 20
var skin : int = 0

#Gravity
var gravity: float = 0.5
var gravityTimer: float = 0

#Handling
var isMovingLeft: bool = false
var isMovingRight: bool = false
var movementPriority: int = 0 #0 Left, 1 Rigth
var isSoftDroping: bool = false
var isLockTimerActive: bool = false
var currentLockTimer: float = 0
var lockTimer: float = 0.5
var currentLockRotation: int = 0
var maxLockRotation: int = 15 #Si llega a 15, se bloquea al instante

var maxARR: int = 140 #Cuanto tarda en mover la pieza a la siguiente casilla
var currentARR = 0
var maxDAS: int = 140 #Cuanto tarda en iniciar a mover la pieza sola
var currentDAS = 0
var SDF: int = 6



func _ready():
	await get_tree().create_timer(0.2).timeout #Necesario para que no explote la QUEUE (aun no se adignan las tiles de I y O)
	GetPlayerData()
	nameLabel.text = playerName
	GenerateNewBag(true)
	StartNewGame()

func GetPlayerData():
	if isPlayerOne:
		playerName = Scripter.P1_Name
		maxARR = Scripter.P1_ARR
		maxDAS = Scripter.P1_DAS
		SDF = Scripter.P1_SDF
		useGhost = Scripter.P1_UseGhost
		useGhostColour = Scripter.P1_UseGhostColour
		skin = Scripter.P1_Skin
	else:
		playerName = Scripter.P2_Name
		maxARR = Scripter.P2_ARR
		maxDAS = Scripter.P2_DAS
		SDF = Scripter.P2_SDF
		useGhost = Scripter.P2_UseGhost
		useGhostColour = Scripter.P2_UseGhostColour
		skin = Scripter.P2_Skin
		
		

func StartNewGame():
	gameActive = true
	SpawnNewPiece()

func StopGame():
	gameActive = false
	GamePaused.emit()
	ClearActivePiece()

	
func ResetBoard():
	gameActive = false
	mainGrid.clear()
	activeGrid.clear()
	ghostGrid.clear()
	dangerGrid.clear()
	holdManager.ResetHold()
	GenerateNewBag(true)
	
	
func GenerateNewBag(isNewGame):
	if isNewGame:
		currentBag = bag.duplicate()
		currentBag.shuffle()
	bag.shuffle()
	currentBag += bag
	
func _process(delta):
	#region Movement
	if isMovingLeft and isMovingRight:
		if currentDAS <= maxDAS:
			currentDAS += delta * 1000
		else:
			if maxARR == 0:
				if movementPriority == 0:
					InstaARR(0)
				else:
					InstaARR(1)
			elif currentARR <= maxARR:
				currentARR += delta * 1000
			else:
				currentARR = 0
				if movementPriority == 0:
					MovePiece(0)
				else:
					MovePiece(1)
	else:
		if isMovingLeft:
			if currentDAS <= maxDAS:
				currentDAS += delta * 1000
			else:
				if maxARR == 0: #ARR 0 is broken. It doesn't snap the piece to the extreme side of the board
					InstaARR(0)
				elif currentARR <= maxARR:
					currentARR += delta * 1000
				else:
					currentARR = 0
					MovePiece(0)
		if isMovingRight:
			if currentDAS <= maxDAS:
				currentDAS += delta * 1000
			else:
				if maxARR == 0: 
					InstaARR(1)
				elif currentARR <= maxARR:
					currentARR += delta * 1000
				else:
					currentARR = 0
					MovePiece(1)
	#endregion
	
	if isSoftDroping:
		if SDF > 40:
			InstaSoftDrop()
		else:
			gravityTimer += delta * SDF
		
	else:
		gravityTimer +=  delta
	if gravityTimer >= gravity:
		gravityTimer = 0.0 
		ApplyGravity()
	
	#region Lock Piece Timer
	
	if isLockTimerActive:
		if currentLockTimer < lockTimer:
			currentLockTimer += delta
		else:
			pass
			LockPiece()
	#endregion

func ApplyGravity():
	if gameActive:
		ClearActivePiece()
		var canMoveDown = true
		for block in currentPieceTiles:
			var newPos = currentPieceCoords + block + Vector2i(0,1)
			if newPos.y >= boardHeight or not IsCellEmpty(newPos):
				canMoveDown = false
				break
		if canMoveDown:
			isLockTimerActive = false
			currentPieceCoords.y += 1
			if(isSoftDroping):
				PlayAudio(sfxSoftDrop)
			if not isLockTimerActive:
				for block in currentPieceTiles:
					var tmpPos = currentPieceCoords + block + Vector2i(0,1)
					if tmpPos.y >= boardHeight or not IsCellEmpty(tmpPos):
						isLockTimerActive = true
						PlayAudio(sfxHitFloor)
						break
		else:
			if not isLockTimerActive:
				isLockTimerActive = true
				PlayAudio(sfxHitFloor)
		DrawPiece(0, currentPieceTiles, currentPieceCoords)
	
func _input(event):
	if isPlayerOne:
		if event.is_action_pressed("P1_MV_L"):
			if gameActive:
				MovePiece(0)
				movementPriority = 0
				isMovingLeft = true
				currentDAS = 0
				currentARR = 0
		if event.is_action_released("P1_MV_L"):
			if gameActive:
				isMovingLeft = false
				currentDAS = 0
				currentARR = 0
			#;aybe reset some values, not sure if make it here or its own function
		if event.is_action_pressed("P1_MV_R"):
			if gameActive:
				MovePiece(1)
				movementPriority = 1
				isMovingRight = true
				currentDAS = 0
				currentARR = 0
		if event.is_action_released("P1_MV_R"):
			if gameActive:
				isMovingRight = false
				currentDAS = 0
				currentARR = 0
		
		if event.is_action_pressed("P1_CW"):
			if gameActive:
				RotatePiece(1)
		if event.is_action_pressed("P1_CCW"):
			if gameActive:
				RotatePiece(0)
		if event.is_action_pressed("P1_180"):
			if gameActive:
				RotatePiece(2)
			
		if event.is_action_pressed("P1_HD"):
			if gameActive:
				HardDrop()
			
		if event.is_action_pressed("P1_SD"):
			if gameActive:
				#SoftDrop()#temp
				isSoftDroping = true
		if event.is_action_released("P1_SD"):
			if gameActive:
				isSoftDroping = false
			
		if event.is_action_pressed("P1_HOLD"):
			if gameActive:
				TriggerHold()
	else:
		if event.is_action_pressed("P2_MV_L"):
			if gameActive:
				MovePiece(0)
				movementPriority = 0
				isMovingLeft = true
				currentDAS = 0
				currentARR = 0
		if event.is_action_released("P2_MV_L"):
			if gameActive:
				isMovingLeft = false
				currentDAS = 0
				currentARR = 0
			#;aybe reset some values, not sure if make it here or its own function
		if event.is_action_pressed("P2_MV_R"):
			if gameActive:
				MovePiece(1)
				movementPriority = 1
				isMovingRight = true
				currentDAS = 0
				currentARR = 0
		if event.is_action_released("P2_MV_R"):
			if gameActive:
				isMovingRight = false
				currentDAS = 0
				currentARR = 0
		
		if event.is_action_pressed("P2_CW"):
			if gameActive:
				RotatePiece(1)
		if event.is_action_pressed("P2_CCW"):
			if gameActive:
				RotatePiece(0)
		if event.is_action_pressed("P2_180"):
			if gameActive:
				RotatePiece(2)
			
		if event.is_action_pressed("P2_HD"):
			if gameActive:
				HardDrop()
			
		if event.is_action_pressed("P2_SD"):
			if gameActive:
				#SoftDrop()#temp
				isSoftDroping = true
		if event.is_action_released("P2_SD"):
			if gameActive:
				isSoftDroping = false
			
		if event.is_action_pressed("P2_HOLD"):
			if gameActive:
				TriggerHold()
	if event.is_action_pressed("ToggleFullScreen"):
		ReceiveAttack(10)
#region Drawing
func DrawPiece(grid, piece, pos):
	var colour
	var currentDrawingPiece: String
	if piece in I:
		currentDrawingPiece = "I"
		colour = Vector2i(4,0)
	elif piece in J:
		currentDrawingPiece = "J"
		colour = Vector2i(5,0)
	elif piece in L:
		currentDrawingPiece = "L"
		colour = Vector2i(1,0)
	elif piece in O:
		currentDrawingPiece = "O"
		colour = Vector2i(2,0)
	elif piece in T:
		currentDrawingPiece = "T"
		colour = Vector2i(6,0)
	elif piece in S:
		currentDrawingPiece = "S"
		colour = Vector2i(3,0)
	elif piece in Z:
		currentDrawingPiece = "Z"
		colour = Vector2i(0,0)
	else :
		colour = Vector2i(11,0)
		
	if grid == 0: #Active Piece
		currentPiece = currentDrawingPiece
		currentPieceTiles = piece
		currentPieceCoords = pos
		for i in piece:
			activeGrid.set_cell(pos + i, skin, colour)
	elif grid == 1: #Default Board
		for i in piece:
			mainGrid.set_cell(pos + i, skin, colour)
	elif grid == 2: #Ghost Grid
		colour = Vector2i(7,0)
		for i in piece:
			ghostGrid.set_cell(pos + i, skin, colour)
	else:
		colour = Vector2i(11,0)
		for i in piece:
			dangerGrid.set_cell(pos + i, skin, colour)

func DrawGhost():
	if useGhost:
		var tmpPos  = currentPieceCoords
		var maxDropDistance: int = 0
		ghostGrid.clear()
		
		while true:
			var canMoveDown: bool = true
			for block in currentPieceTiles:
				var newPos = currentPieceCoords + block + Vector2i(0, maxDropDistance + 1)
				if newPos.y >= boardHeight or not IsCellEmpty(newPos):
					canMoveDown = false
					break
			if not canMoveDown:
				break
				
			maxDropDistance += 1
		tmpPos.y += maxDropDistance
		
		if useGhostColour:
			var colour: Color = Color8(255,255,255,125)
			if currentPieceTiles in I:
				colour = Color8(18,225,245,125)
			elif currentPieceTiles in J:
				colour = Color8(15,95,210,125)
			elif currentPieceTiles in L:
				colour = Color8(255,145,60,125)
			elif currentPieceTiles in O:
				colour = Color8(235,220,65,125)
			elif currentPieceTiles in T:
				colour = Color8(195,25,215,125)
			elif currentPieceTiles in S:
				colour = Color8(75,215,30,125)
			elif currentPieceTiles in Z:
				colour = Color8(220,50,35,125)
			else:
				colour = Color8(255,0,0,255)
			ghostGrid.modulate = colour
		DrawPiece(2, currentPieceTiles, tmpPos)

func DrawDanger():
	dangerGrid.clear()
	var tmpPos = Vector2i(3,-3)
	var dangerPiece = currentBag[0][0]
	if dangerPiece in O:
		tmpPos = Vector2i(4,-3)
	DrawPiece(3,currentBag[0][0], tmpPos)
	pass

func ClearActivePiece():
	for i in currentPieceTiles:
		activeGrid.erase_cell(currentPieceCoords + i)

#endregion

#region Player Input System

func MovePiece(dir):
	var minX = INF
	var maxX = -INF
	var tmpPos = currentPieceCoords
	var collision = false
	ClearActivePiece()
	for block in currentPieceTiles:
		var blockX = block.x + currentPieceCoords.x
		if blockX < minX:
			minX = blockX
		if blockX > maxX:
			maxX = blockX
	
	if dir == 0: # Left
		tmpPos.x -= 1
		if minX <= 0:
			collision = true
	else: # Right
		tmpPos.x += 1
		if maxX >= boardWidth - 1:
			collision = true
	
	if not collision:
		var usedCells = mainGrid.get_used_cells()
		for block in currentPieceTiles:
			var newPosTile = tmpPos + block
			if newPosTile in usedCells:
				collision = true
				break
	
	if not collision:
		PlayAudio(sfxMove)
		currentPieceCoords = tmpPos
		lastActRotation = false
	if isLockTimerActive:
		currentLockTimer = 0
		if currentLockRotation < maxLockRotation:
			currentLockRotation += 1
		else:
			LockPiece()
	isLockTimerActive = false
	DrawPiece(0, currentPieceTiles, currentPieceCoords)
	DrawGhost()
	

func RotatePiece(dir):
	#var = currentPieceTiles
	var tmpPieceTiles
	var tmpRotation : int = currentPieceRotation
	var rotationID
	var tmpKickTable = kickTable
	var kickTablePiece: int = 1 #1 for O (Unused), J, L, S, T, Z. 2 for I.
	var kickTableAttempts: int = 0
	ClearActivePiece()
	if dir == 0: #CCW
		if tmpRotation == 0:
			tmpRotation = 3
		else:
			tmpRotation -= 1 
	elif dir == 1: #CW
		if tmpRotation == 3:
			tmpRotation = 0
		else:
			tmpRotation += 1
	else: #180
		match tmpRotation:
			0:
				tmpRotation = 2
			1:
				tmpRotation = 3
			2:
				tmpRotation = 0
			3:
				tmpRotation = 1
	match currentPiece:
		"I":
			kickTablePiece = 2
			tmpPieceTiles = I[tmpRotation]
		"J":
			tmpPieceTiles = J[tmpRotation]
		"L":
			tmpPieceTiles = L[tmpRotation]
		"O":
			kickTablePiece = 0
			tmpPieceTiles = O[tmpRotation]
		"T":
			tmpPieceTiles = T[tmpRotation]
		"S":
			tmpPieceTiles = S[tmpRotation]
		"Z":
			tmpPieceTiles = Z[tmpRotation]
	if kickTablePiece ==  2:
		tmpKickTable = kickTableI
	else:
		tmpKickTable = kickTable
	match currentPieceRotation:
		0:
			match tmpRotation:
				1:
					rotationID = "0-1"
				2:
					rotationID = "0-2"
				3:
					rotationID = "0-3"
		1:
			match tmpRotation:
				0:
					rotationID = "1-0"
				2:
					rotationID = "1-2"
				3:
					rotationID = "1-3"
		2:
			match tmpRotation:
				0:
					rotationID = "2-0"
				1:
					rotationID = "2-1"
				3:
					rotationID = "2-3"
		3:
			match tmpRotation:
				0:
					rotationID = "3-0"
				1:
					rotationID = "3-1"
				2:
					rotationID = "3-2"
	
	var isColliding: bool = false
	while kickTableAttempts < 5:
		isColliding = false
		var offset = tmpKickTable[rotationID][kickTableAttempts]
		for block in tmpPieceTiles:
			var tmpPos = currentPieceCoords + block + offset
			if not IsCellEmpty(tmpPos):
				isColliding =  true
				break
		if not isColliding:
			currentPieceCoords += offset
			#print("Rotating with ", kickTableAttempts, " attempts.")
			currentPieceTiles = tmpPieceTiles
			currentPieceRotation = tmpRotation
			lastActRotation = true
			if IsTSpin() > 0 and currentPiece == "T":
				PlayAudio(sfxSpin)
			else:
				PlayAudio(sfxRotate)
			break
		else:
			kickTableAttempts += 1
	
	DrawPiece(0, currentPieceTiles, currentPieceCoords)
	DrawGhost()
	if isLockTimerActive:
		currentLockTimer = 0
		if currentLockRotation < maxLockRotation:
			currentLockRotation += 1
		else:
			LockPiece()

func HardDrop():
	ClearActivePiece()
	var maxDropDistance = 0
	while true:
		var canMoveDown = true
		for block in currentPieceTiles:
			var new_pos = currentPieceCoords + block + Vector2i(0, maxDropDistance + 1)
			if new_pos.y >= boardHeight or not IsCellEmpty(new_pos):
				canMoveDown = false
				break
		if not canMoveDown:
			break
		maxDropDistance += 1
	currentPieceCoords.y += maxDropDistance
	PlayAudio(sfxHardDrop)
	LockPiece(true)

func InstaARR(direction: int):
	ClearActivePiece()
	var maxMoveDistance = 0
	while true:
		var canMove = true
		for block in currentPieceTiles:
			var newPos
			if direction == 0:
				newPos = currentPieceCoords + block + Vector2i(maxMoveDistance -  1, 0)
				if newPos.x < 0 or not IsCellEmpty(newPos):
					canMove = false
					break
			else:
				newPos = currentPieceCoords + block + Vector2i(maxMoveDistance + 1, 0)
				if newPos.x >= boardWidth or not IsCellEmpty(newPos):
					canMove = false
					break
		if not canMove:
			break
		else:
			PlayAudio(sfxMove)
		if direction == 0:
			maxMoveDistance -= 1
		else:
			maxMoveDistance += 1
	currentPieceCoords.x += maxMoveDistance
	ClearActivePiece()
	DrawPiece(0, currentPieceTiles, currentPieceCoords)
	DrawGhost()


func InstaSoftDrop():
	ClearActivePiece()
	var maxDropDistance = 0
	while true:
		var can_move_down = true
		for block in currentPieceTiles:
			var new_pos = currentPieceCoords + block + Vector2i(0, maxDropDistance + 1)
			if new_pos.y >= boardHeight or not IsCellEmpty(new_pos):
				can_move_down = false
				if not isLockTimerActive:
					isLockTimerActive = true
					PlayAudio(sfxHitFloor)
				break
		if not can_move_down:
			break
		maxDropDistance += 1
	currentPieceCoords.y += maxDropDistance
	ClearActivePiece()
	DrawPiece(0, currentPieceTiles, currentPieceCoords)

#endregion

#region GameLogic
func LockPiece(suppressLockSound = false):
	isLockTimerActive = false
	currentLockTimer = 0
	currentLockRotation = 0
	ClearActivePiece()
	DrawPiece(1, currentPieceTiles, currentPieceCoords)	
	ghostGrid.clear()
	dangerGrid.clear()
		
	var linesCleared = ScanFullLines()
	
	if mainGrid.get_used_cells().is_empty():
		AttackCalculator(linesCleared, true)
	else:
		AttackCalculator(linesCleared)
	SpawnNewPiece()
	if not suppressLockSound:
		PlayAudio(sfxLockPiece)	
	LockedPiece.emit()

func IsTSpin() -> int:
	if not lastActRotation or currentPiece != "T":
		tSpinType = 0
		return 0
	else:
		var corners = [
			Vector2i(0,0),
			Vector2i(0,2),
			Vector2i(2,0),
			Vector2i(2,2)
			]
			
		var filledCorners = 0
		
		for corner in corners:
			var checkPos = currentPieceCoords + corner
			if not IsCellEmpty(checkPos):
				if isDebug:
					mainGrid.set_cell(checkPos, 0, Vector2i(11,0))
				filledCorners += 1
				
		print (filledCorners)
		if filledCorners >= 1:
			#if IsFacingTwoCorners(corners):
			if filledCorners >= 3:
				tSpinType = 2
				print("T SPIN")
				return tSpinType
			else:
				tSpinType = 1
				print("T SPIN MINI")
				return tSpinType
		else:
			tSpinType = 0
			return 0
		
func IsFacingTwoCorners(corners) -> bool: #Used for T-Spin calculations
	var facingCorners = 0
	for i in range(4):
		var checkPos = currentPieceCoords + corners[i]
		print(checkPos, " ", i)
		if not IsCellEmpty(checkPos): #This is broken and i don't know how it works anymore
			if i == 1 or i == 3: # Asumiendo que los índices 1 y 3 son los laterales de la pieza "T" (future me. i don't even know what was my logic in here)
				facingCorners += 1
			#facingCorners += 1
	print("Facing corners: ", facingCorners)
	if facingCorners >= 2:
		return true
	else:
		return false
#I think this function was made to try and analyze each of the "T arms" (yellow circles) and see if it was "surrounded" (red and orange X's. see "tspin reference" in the references folder) 

func AttackCalculator(linesCleared: int, perfectCleared: bool = false):
	var attack: int = 0
	var comboSound
	Lines.emit(linesCleared)
	if not inCombo and linesCleared > 0:
		inCombo = true
	elif inCombo and linesCleared > 0:
		combo += 1
		Combo.emit(combo)
		match combo:
			1:
				comboSound = sfxCombo1
			2:
				comboSound = sfxCombo2
			3:
				comboSound = sfxCombo3
			4:
				comboSound = sfxCombo4
			5:
				comboSound = sfxCombo5
			6:
				comboSound = sfxCombo6
			7:
				comboSound = sfxCombo7
			8:
				comboSound = sfxCombo8
			9:
				comboSound = sfxCombo9
			10:
				comboSound = sfxCombo10
			11:
				comboSound = sfxCombo11
			12:
				comboSound = sfxCombo12
			13:
				comboSound = sfxCombo13
			14:
				comboSound = sfxCombo14
			15:
				comboSound = sfxCombo15
			_:
				comboSound = sfxCombo16
	PlayAudio(comboSound)
	
	if perfectCleared == true:
		attack += 10
		PlayAudio(sfxPC)
	
	match linesCleared:
		0:
			if inCombo and combo >= 3:
				PlayAudio(sfxComboBreak)
			inCombo = false
			combo = 0
			if not pendingGarbage.is_empty():
				var totalGarbage = 0
				for garbage in pendingGarbage:
					totalGarbage += garbage
				AddGarbage(totalGarbage)
				pendingGarbage = []
				Garbage.emit(0)
		1:
			if tSpinType > 0:
				PlayAudio(sfxClearSpin)
				if not inB2B:
					inB2B = true
				else:
					attack += 1
					b2b += 1
				if tSpinType == 2:
					attack += 2
				B2B.emit()
				B2BCombo.emit(b2b)
			else:
				inB2B = false
				b2b = 0
				B2BCombo.emit(b2b)
				B2BCombo.emit(b2b)
				PlayAudio(sfxClearLine)
			
		2:
			attack += 1
			if tSpinType > 0:
				PlayAudio(sfxClearSpin)
				if not inB2B:
					inB2B = true
				else:
					attack += 1
					b2b += 1
				if tSpinType == 2:
					attack += 3
				B2B.emit()
				B2BCombo.emit(b2b)
			else:
				inB2B = false
				b2b = 0
				B2BCombo.emit(b2b)
				B2BCombo.emit(b2b)
				PlayAudio(sfxClearLine)
		3:
			attack += 2
			if tSpinType > 0:
				PlayAudio(sfxClearSpin)
				if not inB2B:
					inB2B = true
				else:
					attack += 1
					b2b += 1
				if tSpinType == 2:
					attack += 4
				B2B.emit()
				B2BCombo.emit(b2b)
			else:
				inB2B = false
				b2b = 0
				B2BCombo.emit(b2b)
				B2BCombo.emit(b2b)
				PlayAudio(sfxClearLine)
		4:
			attack += 4
			if not inB2B:
				inB2B = true
				PlayAudio(sfxClearTetra)
			else:
				attack += 1
				b2b += 1
				PlayAudio(sfxClearB2B)
				B2B.emit()
				B2BCombo.emit(b2b)
	while attack > 0 and not pendingGarbage.is_empty():
		var garbage = pendingGarbage[0]
		if garbage <= attack:
			attack -= garbage
			pendingGarbage.remove_at(0)
		else:
			pendingGarbage[0] -= attack
			attack = 0
	var garbageTotal = 0
	if not pendingGarbage.is_empty():
		for garbage in pendingGarbage:
			garbageTotal += garbage
	Garbage.emit(garbageTotal)
	
	
	if attack > 0:
		Attack.emit(attack)

func AddGarbage(attack: int):
	var holePos = randi() % boardWidth
	
	MoveLinesUp(attack)
	
	for i in range(attack):
		for x in range(boardWidth):
			if x == holePos:
				mainGrid.erase_cell(Vector2i(x, boardHeight - i - 1))
			else:
				mainGrid.set_cell(Vector2i(x, boardHeight - i - 1), skin, Vector2i(9,0))

func MoveLinesUp(rows: int):
	for y in range(-19, boardHeight - rows):
		for x in range(boardWidth):
			var tmpBoard = mainGrid.get_cell_atlas_coords(Vector2i(x, y + rows))
			if tmpBoard == Vector2i(-1, -1):
				mainGrid.erase_cell(Vector2i(x, y))
			else:
				mainGrid.set_cell(Vector2i(x,y), skin, tmpBoard)
		

func IsCellEmpty(pos: Vector2i) -> bool:
	var collision = false
	var usedCells = mainGrid.get_used_cells()
	if pos.x >= 0 and pos.x <= boardWidth and pos.y < boardHeight:
		if pos in usedCells:
			collision = true
	else:
		collision = true
	if pos.x <0 || pos.x >=boardWidth:
		collision = true
	return not collision #Inverts value cause cell's not empty




#endregion

func GameOver():
	PlayAudio(sfxTopOut)
	gameActive = false
	TopedOut.emit()
	pass



func SpawnNewPiece():
	tSpinType = 0
	lastActRotation = false
	if currentBag.size() < 6:
		GenerateNewBag(false)
		
	var newPiece = currentBag.pop_front()
	#newPiece = T
	#print(newPiece)
	currentPieceRotation = 0
	var newPos: Vector2i = Vector2i(3,-3)
	if newPiece == O:
		newPos = Vector2i(4,-3)
	DrawPiece(0, newPiece[currentPieceRotation], newPos)
	var collision = false
	for block in currentPieceTiles:
		var usedCells = mainGrid.get_used_cells()
		if currentPieceCoords + block in usedCells:
			collision = true
			GameOver()
			break
	if not collision:
		DrawGhost()
		DrawDanger()
	
	#Update Queue
	var queue = 0
	while queue < 5:
		var queuePiece: String
		if currentBag[queue][0] in I:
			queuePiece = "I"
			#print("Piece I")
		elif currentBag[queue][0] in J:
			queuePiece = "J"
			#print("Piece J")
		elif currentBag[queue][0] in L:
			queuePiece = "L"
			#print("Piece L")
		elif currentBag[queue][0] in O:
			queuePiece = "O"
			#print("Piece O")
		elif currentBag[queue][0] in T:
			queuePiece = "T"
			#print("Piece T")
		elif currentBag[queue][0] in S:
			queuePiece = "S"
			#print("Piece S")
		elif currentBag[queue][0] in Z:
			queuePiece = "Z"
			#print("Piece Z")
		else:
			print("ERROR IN IDENTIFYING")
		#print("Sending Queue Manager piece: ", queuePiece, " in queue order: ", queue)
		queueManager.UpdateQueue(queuePiece, queue)
		queue += 1

func PlayAudio(clip):
	var player = audioPlayer.instantiate()
	add_child(player)
	player.stream = clip
	player.play()

func ScanFullLines() -> int:
	var row : int = boardHeight - 1
	var linesCleared : int = 0
	while row > -19:
		var count = 0
		for i in range(boardWidth):
			if not IsCellEmpty(Vector2i(i, row)):
				count += 1
		#Erase Method
		if count == boardWidth:
			MoveLinesDown(row)
			linesCleared += 1
		else:
			row -= 1
	return linesCleared

func ClearLine(y): #Unused
	for x in range(0, boardWidth):
		mainGrid.erase_cell(Vector2i(x, y))

func MoveLinesDown(startY):
	var tmpBoard
	#print("Start moving lines: ", startY)
	for y in range(startY, -19, -1):
		for x in range(boardWidth):
			tmpBoard = mainGrid.get_cell_atlas_coords(Vector2i(x , y - 1))
			if(tmpBoard == Vector2i(-1, -1)):
				mainGrid.erase_cell(Vector2i(x ,y))
			else:
				mainGrid.set_cell(Vector2i(x, y ), skin, tmpBoard)

func TriggerHold():
	var canHold = holdManager.SwapHoldPiece(currentPiece)
	if canHold:
		currentPiece = holdManager.TransferSwapPiece()
		ClearActivePiece()
		PlayAudio(sfxHold)
		lastActRotation = false
		if currentPiece == "":
			SpawnNewPiece()
		else:
			SetManualPiece(currentPiece)

func SetManualPiece(piece):
	tSpinType = 0
	if gameActive:
		currentPieceRotation = 0
		match piece:
				"I":
					currentPiece = "I"
					DrawPiece(0,I[0], Vector2i(3,-3))
				"J":
					currentPiece = "J"
					DrawPiece(0,J[0], Vector2i(3,-3))
				"L":
					currentPiece = "L"
					DrawPiece(0,L[0], Vector2i(3,-3))
				"O":
					currentPiece = "O"
					DrawPiece(0,O[0], Vector2i(4,-3))
				"T":
					currentPiece = "T"
					DrawPiece(0,T[0], Vector2i(3,-3))
				"S":
					currentPiece = "S"
					DrawPiece(0,S[0], Vector2i(3,-3))
				"Z":
					currentPiece = "Z"
					DrawPiece(0,Z[0], Vector2i(3,-3))
		var collision = false
		for block in currentPieceTiles:
			var usedCells = mainGrid.get_used_cells()
			if currentPieceCoords + block in usedCells:
				collision = true
				GameOver()
				break
		if not collision:
			DrawGhost()
			DrawDanger()
		lastActRotation = false
		
func ReceiveAttack(attack: int):
	pendingGarbage.append(attack)
	var totalGarbage = 0
	for garbage in pendingGarbage:
		totalGarbage += garbage
	Garbage.emit(totalGarbage)
