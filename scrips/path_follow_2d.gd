extends PathFollow2D

var speed = 0.25

func _process(delta):
	progress_ratio += delta * speed


func _on_wolf_2_0_dead() -> void:
	print("I Died")
	queue_free()
