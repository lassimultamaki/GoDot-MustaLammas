extends Label


var max_sheep = 4
var current_sheep = max_sheep
var sheeps_used = 0

@onready var sheep_count: Label = $"."

func _on_sheep_sheep_used() -> void:
	sheeps_used = int(sheeps_used) + 1
	

func _ready():
	set_sheep_count()
	

func set_sheep_count():
	sheep_count.text = "Sheeps left " + str(current_sheep)
	
	
func use_sheep(sheeps_used):
	current_sheep -= sheeps_used
