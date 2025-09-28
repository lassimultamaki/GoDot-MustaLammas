extends CharacterBody2D
@export var target: Node2D
@onready var animationSprite : AnimatedSprite2D = $AnimatedSprite2D
@export var Health: int = 1
var damage_taken = 0
var second = false
var moment = false
signal sheep_used
signal go
signal went
func _set_animation():
	animationSprite.play("idle")

const SPEED = 300
const JUMP_VELOCITY = -100

func _physics_process(_delta):
	
	if not is_on_floor():
		velocity += get_gravity() * _delta

	_calculate_velocity()

	_set_animation()

	move_and_slide()

func _calculate_velocity():
	var distanceToTarget = 20
	var sheepNumber = int(name.replace("Sheep", ""))
	var sheepMultiplicator = 1 if sheepNumber == 0 else sheepNumber
	var targetPosition = target.position - Vector2(0, -9)
	sheepNumber = 2
	if position.distance_to(targetPosition) > distanceToTarget * sheepMultiplicator:
		var direction = (targetPosition - position).normalized()
		velocity = direction * SPEED
		velocity.y *= 3
	elif position.y - targetPosition.y < -2 || position.y - targetPosition.y > 2:
		velocity.x = 0
	else:
		velocity = Vector2.ZERO


func _on_player_sacrofice() -> void:
	sheep_used.emit()
	animationSprite.play("two sheep")
	if second:
			animationSprite.play("one sheep")
			if moment:
				queue_free()	
			else:
				went.emit()
	else:	
		go.emit()
	

	


func _on_go() -> void:
	second = true
	
	


func _on_went() -> void:
	moment = true
