extends ProgressBar

@export var player: Player

func _ready():
	update()

func update():
	value = player.currentHP * 100 / player.maxHP
