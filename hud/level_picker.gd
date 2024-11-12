extends Control

const LEVELS_PATH = "res://levels/"
@export var level_entry: PackedScene
@onready var level_picker_container = $VBoxContainer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	load_levels()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	
func load_levels():
	var dir = DirAccess.open(LEVELS_PATH)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if file_name.ends_with(".tres"):  # Assuming LevelData files are saved as .tres resources
				var level_entry = level_entry.instantiate()
				level_entry.get_node("Label").text = file_name
				level_picker_container.add_child(level_entry)
			file_name = dir.get_next()
		dir.list_dir_end()
