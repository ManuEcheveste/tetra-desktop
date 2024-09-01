extends AudioStreamPlayer

func FinishedPlaying():
	queue_free()
