extends CharacterBody2D

signal sacrofice 

const SPEED = 500.0
var JUMP_VELOCITY = -900.0
var stop = false

signal swing
signal sacrofise_buff
signal stop_buff
@onready var buff: Timer = $AnimatedSprite2D/Buff
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
	if event.is_action_pressed("Sacrofise"):
		if stop ==false:
			sacrofice.emit()
			buff.start()
			sacrofise_buff.emit()
			print("player is buffet")
			animated_sprite_2d.play("sacrofice")
			print("A sheep will be sacroficet")
			JUMP_VELOCITY = -1000
func _on_timer_timeout() -> void:
			attack_going = false

			
func _on_weaponhitbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("Hurtable"):
		print("Hit")
		


func _on_buff_timeout() -> void:
	stop_buff.emit()


func _on_sheep_stop() -> void:
	stop = true
