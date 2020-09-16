extends Spatial

var rotate := false
var rotation_scale := 0.005
var rotation_vertical_limit := PI / 2
var rotation_vertical_limited := true

var zoom_in := false
var zoom_out := false
var zoom_amount := 0.1
var zoom_direction := 0

onready var spring_arm: SpringArm = $SpringArm


func _unhandled_input(event) -> void:
	zoom_in = false
	zoom_out = false
	zoom_direction = 0
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			rotate = event.pressed
		zoom_in = event.button_index == BUTTON_WHEEL_UP
		zoom_out = event.button_index == BUTTON_WHEEL_DOWN
	elif event is InputEventMouseMotion:
		if rotate:
			var angle_horizontal: float = -event.relative.x * rotation_scale
			var angle_vertical: float = -event.relative.y * rotation_scale
			_rotate_horizontally(angle_horizontal)
			_rotate_vertically(angle_vertical)
	if zoom_in or zoom_out:
		zoom_direction = 1 if zoom_in else -1
		spring_arm.spring_length += zoom_amount * zoom_direction


func _rotate_horizontally(angle: float) -> void:
	rotate_y(angle)


func _rotate_vertically(angle: float) -> void:
	if rotation_vertical_limited:
		var predicted := spring_arm.rotation.x + angle
		if abs(predicted) > rotation_vertical_limit:
			var excess := abs(predicted) - rotation_vertical_limit
			angle -= excess * sign(predicted)
	spring_arm.rotate_x(angle)
