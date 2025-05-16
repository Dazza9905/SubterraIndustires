extends Control

var load_progress: Array[int]
@export var level_picker: PackedScene
@export var progress_bar: ProgressBar

func _ready() -> void:
	self.get_tree().paused = false
	for i in range(0, 101):
		load_progress.append(i)

func _on_begin_pressed() -> void:
	ResourceLoader.load_threaded_request("res://levels/level1.tscn")
	progress_bar.visible = true
	
func _process(_delta: float) -> void:
	var _status := ResourceLoader.load_threaded_get_status("res://levels/level1.tscn", load_progress)
	
	var load_desatinne: float = load_progress[0]

	#print(load_desatinne)
	#print(load_desatinne*100)
	
	var tween := get_tree().create_tween()
	tween.tween_property(progress_bar, "value", load_desatinne*100, 0.1)
	
	
	if (ResourceLoader.THREAD_LOAD_LOADED == ResourceLoader.load_threaded_get_status("res://levels/level1.tscn", load_progress)):
		await get_tree().create_timer(0.5).timeout
		get_tree().change_scene_to_packed(ResourceLoader.load_threaded_get("res://levels/level1.tscn"))

func _on_load_game_pressed() -> void:
	get_tree().change_scene_to_packed(level_picker)
