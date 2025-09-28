extends PathFollow2D

var speed = 0.3

func _process(delta):
	progress_ratio += delta * speed
