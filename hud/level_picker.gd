extends Control

const LEVELS_PATH = "res://levels/"
@export var level_entry: PackedScene
@onready var level_picker_container = $VBoxContainer/WorldsCointainer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.reload_worlds.connect(reload_worlds)
	load_levels()


	
func load_levels():
	var dir = DirAccess.open(LEVELS_PATH)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if file_name.ends_with(".tscn"):  # Assuming LevelData files are saved as .tres resources
				var level_entry = level_entry.instantiate()
				level_entry.get_node("Label").text = file_name
				level_picker_container.add_child(level_entry)
			file_name = dir.get_next()
		dir.list_dir_end()

func reload_worlds() -> void:
	for child in level_picker_container.get_children():
		child.queue_free()
	load_levels()
	

func _on_button_pressed() -> void:
	get_tree().change_scene_to_packed(load("res://hud/main_menu.tscn"))


func _on_create_pressed() -> void:
	GameManager.create_world($VBoxContainer/HBoxContainer/LineEdit.text)
