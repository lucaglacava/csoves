extends VBoxContainer

@onready var heartGUIclass = preload("res://scenes/ciggui.tscn")

func _ready() -> void:
	pass

func setmaxhearts(max: int):
	for i in range(max):
		var heart = heartGUIclass.instantiate()
		add_child(heart)
		

func updatehearts(currentHP: int):
	var hearts = get_children()
	
	for i in range(currentHP):
		hearts[i].update(true)
	
	for i in range(currentHP, hearts.size()):
		hearts[i].update(false)
	
