extends CharacterBody2D

# Variable for movement speed
var speed = 200

func _physics_process(delta):
	# Capture input for movement using arrow keys or mapped movement inputs
	var input_direction = Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	)

	# Normalize input direction to maintain consistent speed when moving diagonally
	if input_direction.length() > 0:
		input_direction = input_direction.normalized()

	# Move the character using the move_and_slide method
	velocity = input_direction * speed
	move_and_slide()
