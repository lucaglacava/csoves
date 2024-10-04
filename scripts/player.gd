extends CharacterBody2D

var speed = 100
var player_state

signal HPchanged

@export var maxHP = 3
@onready var currentHP: int = maxHP
@onready var hurtbox = $hurtbox
@export var knockbackPower: int = 1000
@onready var effects = $Effects
@onready var hurttimer = $hurttimer

var isHurt: bool = false



func _ready():
	effects.play("RESET")

func _physics_process(delta):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if direction.x == 0 and direction.y == 0:
		player_state = "idle"
	elif direction.x != 0 or direction.y != 0: 
		player_state = "move"
		
	velocity = direction * speed
	move_and_slide()
	handleCollision()
	play_animation(direction)
	if !isHurt:
		for area in hurtbox.get_overlapping_areas():
			if area.name == "hitbox":
				hurtByEnemy(area)
	
func play_animation(direction):
	if player_state == "idle":
		$AnimatedSprite2D.play("idle")
	if player_state == "move":
		$AnimatedSprite2D.play("walk")
	if player_state == "move" and direction.x <= -0.5:
		$AnimatedSprite2D.flip_h = true
	if player_state == "move" and direction.x >= 0.5:
		$AnimatedSprite2D.flip_h = false

func handleCollision():
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		$AnimatedSprite2D.play("hurt")

func player():
	pass

func hurtByEnemy(area):
	currentHP -= 1
	if currentHP < 0:
		currentHP = maxHP
	
	HPchanged.emit(currentHP)
	isHurt = true
		
	knockback(area.get_parent().velocity)
	effects.play("hurtblink")
	hurttimer.start()
	await hurttimer.timeout
	effects.play("RESET")
	isHurt = false

func _on_hurtbox_area_entered(area):
	if area.has_method("collect"):
		area.collect()
	

func knockback(enemyVelocity: Vector2):
	var knockbackDirection = (enemyVelocity - velocity).normalized() * knockbackPower
	velocity = knockbackDirection
	print_debug(velocity)
	print_debug(position)
	move_and_slide()
	print_debug("   ")
	print_debug(velocity)
	print_debug(position)


func _on_hurtbox_area_exited(area): pass
