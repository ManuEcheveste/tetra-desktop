extends TileMapLayer

@onready var TileMapO = $TileMapO
@onready var TileMapI = $TileMapI


var I := [Vector2i(0, 0), Vector2i(1, 0), Vector2i(2, 0), Vector2i(3, 0)]
var J := [Vector2i(0, 0), Vector2i(0, 1), Vector2i(1, 1), Vector2i(2, 1)]
var L := [Vector2i(2, 0), Vector2i(0, 1), Vector2i(1, 1), Vector2i(2, 1)]
var O := [Vector2i(0, 0), Vector2i(1, 0), Vector2i(0, 1), Vector2i(1, 1)]
var T := [Vector2i(1, 0), Vector2i(0, 1), Vector2i(1, 1), Vector2i(2, 1)]
var S := [Vector2i(1, 0), Vector2i(2, 0), Vector2i(0, 1), Vector2i(1, 1)]
var Z := [Vector2i(0, 0), Vector2i(1, 0), Vector2i(1, 1), Vector2i(2, 1)]
var N := [Vector2i(0, 0), Vector2i(1, 0), Vector2i(0, 1), Vector2i(1, 1), Vector2i(2,1), Vector2i(2,0), Vector2i(3,0)]

var ActiveTileMap
var currentPiece: String
var skin = 0

func UpdateQueue(piece, pos):
	var tileMap: int = 0 #0 default, 1 is I, 2 is O
	var pieceData
	var newPos
	match piece:
		"I":
			tileMap = 1
			pieceData = I
			currentPiece = "I"
		"J":
			pieceData = J
			currentPiece = "J"
		"L":
			pieceData = L
			currentPiece = "L"
		"O":
			tileMap = 2
			pieceData = O
			currentPiece = "O"
		"T":
			pieceData = T
			currentPiece = "T"
		"S":
			pieceData = S
			currentPiece = "S"
		"Z":
			pieceData = Z
			currentPiece = "Z"
			
	match pos:
		0:
			newPos = Vector2i(0,0)
		1:
			newPos = Vector2i(0,3)
		2:
			newPos = Vector2i(0,6)
		3:
			newPos = Vector2i(0,9)
		4:
			newPos = Vector2i(0,12)
	ClearPiece(newPos)
	print("Calling draw queue: ", piece)
	DrawPiece(tileMap, pieceData, newPos)
	
func DrawPiece(tilemap, piece, pos):
	print("Drawing")
	var colour
	if currentPiece == "I":
		colour = Vector2i(4,0)
	elif currentPiece == "J":
		colour = Vector2i(5,0)
	elif currentPiece == "L":
		colour = Vector2i(1,0)
	elif currentPiece == "O":
		colour = Vector2i(2,0)
	elif currentPiece == "T":
		colour = Vector2i(6,0)
	elif currentPiece == "S":
		colour = Vector2i(3,0)
	elif currentPiece == "Z":
		colour = Vector2i(0,0)
	else:
		print("error")
		colour = Vector2i(8,0)
		
	match tilemap:
		0:
			for i in piece:
				set_cell(pos + i, skin, colour)
		1:
			for i in piece:
				TileMapI.set_cell(pos + i, skin, colour)
		2:
			for i in piece:
				TileMapO.set_cell(pos + i, skin, colour)

func ClearPiece(pos):
	for i in N:
		erase_cell(pos + i)
	for i in N:
		TileMapI.erase_cell(pos + i)
	for i in N:
		TileMapO.erase_cell(pos + i)
