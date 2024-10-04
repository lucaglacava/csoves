extends Node2D

@onready var hearts_container = $CanvasLayer/HeartsContainer
@onready var player = $player
# Called when the node enters the scene tree for the first time.
func _ready():
	hearts_container.setmaxhearts(player.maxHP)
	hearts_container.updatehearts(player.currentHP)
	player.HPchanged.connect(hearts_container.updatehearts)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_inventory_gui_closed() -> void:
	get_tree().paused = false

func _on_inventory_gui_opened() -> void:
	get_tree().paused = true
