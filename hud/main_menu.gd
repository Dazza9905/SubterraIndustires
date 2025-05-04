extends Control

var load_progress: Array[int]

func _ready() -> void:
	self.get_tree().paused = false
	for i in range(0, 101):
		load_progress.append(i)

func _on_begin_pressed() -> void:
	ResourceLoader.load_threaded_request("res://levels/level1.tscn")
	$ProgressBar.visible = true
	
func _process(delta: float) -> void:
	var status := ResourceLoader.load_threaded_get_status("res://levels/level1.tscn", load_progress)
	
	var load_desatinne: float = load_progress[0]
	#
	#print(load_desatinne)
	#print(load_desatinne*100)
	
	var tween := get_tree().create_tween()
	tween.tween_property($ProgressBar, "value", load_desatinne*100, 0.1)
	
	
	if (ResourceLoader.THREAD_LOAD_LOADED == ResourceLoader.load_threaded_get_status("res://levels/level1.tscn", load_progress)):
		await get_tree().create_timer(0.5).timeout
		get_tree().change_scene_to_packed(ResourceLoader.load_threaded_get("res://levels/level1.tscn"))
	
	
	
