extends enemy_movement

func _ready():
	random_generation()
	print(dir)


func _on_timer_timeout() -> void:
	random_generation()
	$Timer.start()
