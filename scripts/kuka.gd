extends Node2D

var state = "full" #empty, full
var player_in_area = false

func _ready() -> void:
	if state != "full":
		$"refill timer".start()

func _process(delta):
	if state != "full":
		$AnimatedSprite2D.play("empty")
	if state == "full":
		$AnimatedSprite2D.play("full")
		if player_in_area:
			if Input.is_action_just_pressed("f"):
				state = "empty"
				$"refill timer".start()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_area = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_area = false

func _on_refill_timer_timeout() -> void:
	if state == "empty":
		state = "full"
		
