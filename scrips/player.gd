extends CharacterBody2D


const SPEED = 500.0
const JUMP_VELOCITY = -900.0

signal swing

@onready var timer: Timer = $Timer
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var attack_1: AnimatedSprite2D = $Attack_1
@export var health : int = 3
var attack_going = false


func _physics_process(delta: float) -> void:
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	
	
	var direction := Input.get_axis("Left", "Right")
	
	if direction > 0:
		animated_sprite_2d.flip_h = false
		
	elif direction < 0:
		animated_sprite_2d.flip_h = true
	
	if direction:
			velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	move_and_slide()
	if attack_going == true:
		return
	else:
		pass
		
		if direction == 0:
			animated_sprite_2d.play("idle")
		else:
			animated_sprite_2d.play("Run")
		
func _input(event):
	if event.is_action_pressed("Attack"):
		attack_going = true
		
		animated_sprite_2d.play("attack")
		swing.emit()
		timer.start()
		
func _on_timer_timeout() -> void:
	attack_going = false
	

func _on_weaponhitbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("Hurtable"):
		print("Hit")
