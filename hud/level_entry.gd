extends HBoxContainer



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_button_pressed() -> void:
	var lvl_dat: LevelData = load(Globals.LEVEL_PATH + $Label.text)
	print(Globals.LEVEL_PATH + $Label.text)
	get_tree().change_scene_to_packed(lvl_dat.level)
