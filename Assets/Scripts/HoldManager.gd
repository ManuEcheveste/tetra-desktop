extends TileMapLayer

@onready var tileMapRegular = $"."
@onready var tileMapO = $TileMapO
@onready var tileMapI = $TileMapI


var activeTileMap = tileMapRegular

var currentHold: String
var oldHold: String
var canHold: bool = true
var skin = 0

var I := [Vector2i(0, 0), Vector2i(1, 0), Vector2i(2, 0), Vector2i(3, 0)]
var J := [Vector2i(0, 0), Vector2i(0, 1), Vector2i(1, 1), Vector2i(2, 1)]
var L := [Vector2i(2, 0), Vector2i(0, 1), Vector2i(1, 1), Vector2i(2, 1)]
var O := [Vector2i(0, 0), Vector2i(1, 0), Vector2i(0, 1), Vector2i(1, 1)]
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
	if piece == "I":
		colour = Vector2i(4,0)
		pieceData = I
		activeTileMap = tileMapI
	elif piece == "J":
		colour = Vector2i(5,0)
		pieceData = J
		activeTileMap = tileMapRegular
	elif piece == "L":
		colour = Vector2i(1,0)
		pieceData = L
		activeTileMap = tileMapRegular
	elif piece == "O":
		colour = Vector2i(2,0)
		pieceData = O
		activeTileMap = tileMapO
	elif piece == "T":
		colour = Vector2i(6,0)
		pieceData = T
		activeTileMap = tileMapRegular
	elif piece == "S":
		colour = Vector2i(3,0)
		pieceData = S
		activeTileMap = tileMapRegular
	elif piece == "Z":
		colour = Vector2i(0,0)
		pieceData = Z
		activeTileMap = tileMapRegular
	else:
		colour = Vector2i(-1,-1)
		pieceData = N
		activeTileMap = tileMapRegular
		
	if holded == true:
		colour = Vector2i(8,0) #HOLD COLOUR
	
	if pieceData != N:
		tileMapRegular.clear()
		tileMapO.clear()
		tileMapI.clear()
		
		for i in pieceData:
			activeTileMap.set_cell(Vector2i(0,0) + i, skin, colour)
