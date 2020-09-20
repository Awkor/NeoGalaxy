extends Spatial

var rotate := false
var rotation_scale := 0.03
var rotation_smooth := true
var rotation_stiffness := 10.0
var rotation_vertical_limit := PI / 2
var rotation_vertical_limited := true

var target: Spatial = null

var zoom_maximum := 512.0
var zoom_minimum := 1.0
var zoom_scale := 0.5
var zoom_smooth := true
var zoom_stiffness := 10.0

onready var spring_arm: SpringArm = $SpringArm
onready var spring_arm_length_target := spring_arm.spring_length

onready var rotation_angle_target_horizontal := spring_arm.rotation.x
onready var rotation_angle_target_vertical := rotation.y


func _unhandled_input(event: InputEvent) -> void:
	var zoom_in := false
	var zoom_out := false
	if event is InputEventMouseButton:
		rotate = event.button_index == BUTTON_LEFT and event.pressed
		zoom_in = event.button_index == BUTTON_WHEEL_DOWN
		zoom_out = event.button_index == BUTTON_WHEEL_UP
	elif event is InputEventMouseMotion:
		if rotate:
			var rotation_angle_change_horizontal: float = -event.relative.x * rotation_scale
			var rotation_angle_change_vertical: float = -event.relative.y * rotation_scale
			rotation_angle_target_horizontal = rotation.y + rotation_angle_change_horizontal
			rotation_angle_target_vertical = spring_arm.rotation.x + rotation_angle_change_vertical
	if zoom_in or zoom_out:
		var zoom_direction := 1 if zoom_in else -1
		var spring_arm_length_change := spring_arm.spring_length * zoom_scale * zoom_direction
		spring_arm_length_target = spring_arm.spring_length + spring_arm_length_change


func _process(delta: float) -> void:
	transform.origin = target.transform.origin
	_rotate_horizontally(rotation_angle_target_horizontal, delta)
	_rotate_vertically(rotation_angle_target_vertical, delta)
	_zoom(spring_arm_length_target, delta)


func _rotate_horizontally(target: float, delta: float) -> void:
	if rotation_smooth:
		var weight := delta * rotation_stiffness
		target = lerp_angle(rotation.y, target, weight)
	rotation.y = target


func _rotate_vertically(target: float, delta: float) -> void:
	if rotation_vertical_limited:
		target = clamp(target, -rotation_vertical_limit, rotation_vertical_limit)
	if rotation_smooth:
		var weight := delta * rotation_stiffness
		target = lerp_angle(spring_arm.rotation.x, target, weight)
	spring_arm.rotation.x = target


func _zoom(target: float, delta: float) -> void:
	target = clamp(target, zoom_minimum, zoom_maximum)
	if zoom_smooth:
		var weight := delta * zoom_stiffness
		target = lerp(spring_arm.spring_length, target, weight)
	spring_arm.spring_length = target
