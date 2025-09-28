extends RigidBody2D

signal dead

@export var Health: int = 3
var damage_taken = 0

func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		damage_taken = int(damage_taken) + 1
		var current_health = int(Health) - int(damage_taken)
		print(current_health)
		if current_health <= 0:
			dead.emit()
			queue_free()
			
