extends CharacterBody2D
class_name enemy_movement

var current_states = enemy_states.MOVEDOWN
enum enemy_states {MOVERIGHT, MOVELEFT, MOVEUP, MOVEDOWN, IDLE}

@export var speed = 100
var dir 

func _physics_process(delta):
	match current_states:
		enemy_states.MOVERIGHT:
			move_right()
		enemy_states.MOVELEFT:
			move_left()
		enemy_states.MOVEUP:
			move_up()
		enemy_states.MOVEDOWN:
			move_down()
		enemy_states.IDLE:
			idle()
	
	move_and_slide()

func random_generation():
	dir = randi() % 5 
	random_direction()

func random_direction():
	match dir:
		0:
			current_states = enemy_states.MOVERIGHT
		1:
			current_states = enemy_states.MOVELEFT
		2:
			current_states = enemy_states.MOVEUP
		3:
			current_states = enemy_states.MOVEDOWN
		4:
			current_states = enemy_states.IDLE

func idle(): 
	velocity = Vector2.ZERO 
	$anim.play("idle")

func move_right():
	velocity = Vector2.RIGHT * speed
	$anim.play("walk") 
	$anim.flip_h = false

func move_left():
	velocity = Vector2.LEFT * speed
	$anim.play("walk")
	$anim.flip_h = true

func move_up():
	velocity = Vector2.UP * speed
	$anim.play("walk")

func move_down():
	velocity = Vector2.DOWN * speed
	$anim.play("walk")
