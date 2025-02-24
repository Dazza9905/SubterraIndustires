extends Label


# Called when the node enters the scene tree
func _ready():
	pass

# Called every frame
func _process(delta):
	# Get the current FPS
	var fps: float = Engine.get_frames_per_second()
	# Update the label text
	self.text = "FPS: " + str(fps)
