extends Spatial

export (NodePath) var path_camera
export (NodePath) var path_spring_arm

var camera_near := 1.0
var camera_far := Chunk.SIZE * 2.0

var fov_change := 2.0
var fov_default := 70.0
var fov_maximum := 90.0
var fov_minimum := 50.0
var fov_smooth := true
var fov_stiffness := 10.0

var movement_direction := Vector3.ZERO
var movement_direction_map := {
	KEY_A: Vector3.LEFT,
	KEY_D: Vector3.RIGHT,
	KEY_KP_ADD: Vector3.UP,
	KEY_KP_SUBTRACT: Vector3.DOWN,
	KEY_S: Vector3.BACK,
	KEY_W: Vector3.FORWARD
}
var movement_speed := 1024.0

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

onready var camera: Camera = get_node(path_camera)
onready var camera_fov_target := camera.fov

onready var spring_arm: SpringArm = get_node(path_spring_arm)
onready var spring_arm_length_target := spring_arm.spring_length

onready var rotation_angle_target_horizontal := spring_arm.rotation.x
onready var rotation_angle_target_vertical := rotation.y


func _ready() -> void:
	camera.near = camera_near
	camera.far = camera_far


func _unhandled_input(event: InputEvent) -> void:
	var zoom_in := false
	var zoom_out := false
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			rotate = event.pressed
		if Input.is_key_pressed(KEY_ALT):
			camera_fov_target += fov_change if event.button_index == BUTTON_WHEEL_UP else 0.0
			camera_fov_target -= fov_change if event.button_index == BUTTON_WHEEL_DOWN else 0.0
			camera_fov_target = clamp(camera_fov_target, fov_minimum, fov_maximum)
		else:
			zoom_in = event.button_index == BUTTON_WHEEL_DOWN
			zoom_out = event.button_index == BUTTON_WHEEL_UP
	elif event is InputEventMouseMotion:
		if rotate:
			var rotation_angle_change_horizontal: float = -event.relative.x * rotation_scale
			var rotation_angle_change_vertical: float = -event.relative.y * rotation_scale
			rotation_angle_target_horizontal = rotation.y + rotation_angle_change_horizontal
			rotation_angle_target_vertical = spring_arm.rotation.x + rotation_angle_change_vertical
	elif event is InputEventKey:
		var key: int = event.scancode
		if movement_direction_map.has(key):
			if event.pressed and event.echo == false:
				movement_direction += movement_direction_map[key]
			elif event.pressed == false:
				movement_direction -= movement_direction_map[key]
	if zoom_in or zoom_out:
		var zoom_direction := 1 if zoom_in else -1
		var spring_arm_length_change := spring_arm.spring_length * zoom_scale * zoom_direction
		spring_arm_length_target = spring_arm.spring_length + spring_arm_length_change


func _process(delta: float) -> void:
	if target:
		global_transform.origin = target.global_transform.origin
	else:
		translate(movement_direction * movement_speed * delta)
	_rotate_horizontally(rotation_angle_target_horizontal, delta)
	_rotate_vertically(rotation_angle_target_vertical, delta)
	_update_fov(camera_fov_target, delta)
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


func _update_fov(target: float, delta: float) -> void:
	if fov_smooth:
		target = lerp(camera.fov, target, delta * fov_stiffness)
	camera.fov = target


func _zoom(target: float, delta: float) -> void:
	target = clamp(target, zoom_minimum, zoom_maximum)
	if zoom_smooth:
		var weight := delta * zoom_stiffness
		target = lerp(spring_arm.spring_length, target, weight)
	spring_arm.spring_length = target
