class_name Window, "res://assets/icons/window.svg"
extends TitledPanelContainer

var drag := false
var h_box_container := HBoxContainer.new()

var packed_scene_button_close := preload("res://scenes/gui/window_container_button_close.tscn")
var packed_scene_button_minimize := preload("res://scenes/gui/window_container_button_minimize.tscn")

onready var button_close: TextureButton = packed_scene_button_close.instance()
onready var button_minimize: TextureButton = packed_scene_button_minimize.instance()


func _ready() -> void:
	._ready()
	title_margin_container.connect("gui_input", self, "_gui_input_title")
	title_margin_container.remove_child(title_label)
	title_margin_container.add_child(h_box_container)
	h_box_container.add_child(title_label)
	h_box_container.add_child(button_minimize)
	h_box_container.add_child(button_close)


func _gui_input_title(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			drag = event.pressed
			var mouse_mode := Input.MOUSE_MODE_CONFINED if drag else Input.MOUSE_MODE_VISIBLE
			Input.set_mouse_mode(mouse_mode)
	elif event is InputEventMouseMotion:
		if drag:
			move(event.relative.x, event.relative.y)


func move(x: int, y: int) -> void:
	rect_position.x += x
	rect_position.y += y
