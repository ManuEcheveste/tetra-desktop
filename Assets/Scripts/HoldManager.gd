extends TileMapLayer



var currentHold: String
var oldHold: String
var canHold: bool = true
var skin = 0

var I := [Vector2i(0, 1), Vector2i(1, 1), Vector2i(2, 1), Vector2i(3, 1)]
var J := [Vector2i(0, 0), Vector2i(0, 1), Vector2i(1, 1), Vector2i(2, 1)]
var L := [Vector2i(2, 0), Vector2i(0, 1), Vector2i(1, 1), Vector2i(2, 1)]
var O := [Vector2i(1, 0), Vector2i(2, 0), Vector2i(1, 1), Vector2i(2, 1)]
var T := [Vector2i(1, 0), Vector2i(0, 1), Vector2i(1, 1), Vector2i(2, 1)]
var S := [Vector2i(1, 0), Vector2i(2, 0), Vector2i(0, 1), Vector2i(1, 1)]
var Z := [Vector2i(0, 0), Vector2i(1, 0), Vector2i(1, 1), Vector2i(2, 1)]
var N := [Vector2i(0, 0), Vector2i(0, 0), Vector2i(0, 0), Vector2i(0, 0)]

func _ready():
	ResetHold()
	clear()

func SwapHoldPiece(newPiece) -> bool:
	var canSwap = canHold
	if canHold:
		oldHold = currentHold
		currentHold = newPiece
		DrawPiece(true, currentHold)
		canHold = false
	return canSwap
	
func TransferSwapPiece() -> String:
	return oldHold
	
func EnableHold():
	canHold = true
	DrawPiece(false, currentHold)
	

func ResetHold():
	oldHold = ""
	currentHold = ""
	EnableHold()
	

func DrawPiece(holded, piece):
	var colour
	var pieceData = L
	var canvasPosX = -125
	var canvasPosY = 40
	if piece == "I":
		colour = Vector2i(4,0)
		pieceData = I
		canvasPosX = -140
		canvasPosY = 25
	elif piece == "J":
		colour = Vector2i(5,0)
		pieceData = J
		canvasPosX = -125
		canvasPosY = 40
	elif piece == "L":
		colour = Vector2i(1,0)
		pieceData = L
		canvasPosX = -125
		canvasPosY = 40
	elif piece == "O":
		colour = Vector2i(2,0)
		pieceData = O
		canvasPosX = -140
		canvasPosY = 40
	elif piece == "T":
		colour = Vector2i(6,0)
		pieceData = T
		canvasPosX = -125
		canvasPosY = 40
	elif piece == "S":
		colour = Vector2i(3,0)
		pieceData = S
		canvasPosX = -125
		canvasPosY = 40
	elif piece == "Z":
		colour = Vector2i(0,0)
		pieceData = Z
		canvasPosX = -125
		canvasPosY = 40
	else:
		colour = Vector2i(-1,-1)
		pieceData = N
		
	position = Vector2i(canvasPosX, canvasPosY)
		
	if holded == true:
		colour = Vector2i(8,0) #HOLD COLOUR
	
	if pieceData != N:
		clear()
		for i in pieceData:
			set_cell(Vector2i(0,0) + i, skin, colour)
