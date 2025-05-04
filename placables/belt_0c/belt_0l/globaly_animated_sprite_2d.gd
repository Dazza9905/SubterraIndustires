extends AnimatedSprite2D
class_name GlobalyAnimatedSprite2D

var anim_frame_count: int = 0
var anim_name: String

func _enter_tree() -> void:
	anim_name = sprite_frames.get_animation_names().get(0)
	anim_frame_count = sprite_frames.get_frame_count(anim_name)
	
func _process(delta: float) -> void:
	if anim_frame_count > 0:
		frame = Globals.global_frame % anim_frame_count
