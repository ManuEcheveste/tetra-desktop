extends AudioStreamPlayer

func FinishedPlaying():
	queue_free()
	self.queue_free()
