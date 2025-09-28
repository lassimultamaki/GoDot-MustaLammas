extends RigidBody2D

signal dead

@export var Health: int = 2
var damage_taken = 0
var is_buff_active = false

func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		if is_buff_active:
			damage_taken = int(damage_taken) + 3
		
		else:
			damage_taken = int(damage_taken) + 1
	var current_health = int(Health) - int(damage_taken)
	print(current_health)
	if current_health <= 0:
		dead.emit()			
		queue_free()
			
			
func _on_player_sacrofise_buff() -> void:
	is_buff_active = true
	

func _on_player_stop_buff() -> void:
	is_buff_active = false
