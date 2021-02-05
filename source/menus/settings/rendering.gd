extends Node

export (NodePath) var path_button_apply
export (NodePath) var path_button_back
export (NodePath) var path_check_box_vertical_synchronization
export (NodePath) var path_line_edit_rendering_height
export (NodePath) var path_line_edit_rendering_width
export (NodePath) var path_option_button_msaa

onready var button_apply := get_node(path_button_apply)
onready var button_back := get_node(path_button_back)
onready var check_box_vertical_synchronization := get_node(path_check_box_vertical_synchronization)
onready var line_edit_rendering_height := get_node(path_line_edit_rendering_height)
onready var line_edit_rendering_width := get_node(path_line_edit_rendering_width)
onready var option_button_msaa := get_node(path_option_button_msaa)

onready var settings_menu := load("res://scenes/menus/settings/settings.tscn")
onready var scene_tree := get_tree()


func _ready() -> void:
	button_apply.connect("pressed", self, "_on_ButtonApply_pressed")
	button_back.connect("pressed", self, "_on_ButtonBack_pressed")
	check_box_vertical_synchronization.pressed = OS.vsync_enabled
	line_edit_rendering_height.text = str(OS.window_size.y)
	line_edit_rendering_width.text = str(OS.window_size.x)
	_add_msaa_options(option_button_msaa)


func _add_msaa_options(option_button: OptionButton) -> void:
	option_button.add_item("Disabled", Viewport.MSAA_DISABLED)
	option_button.add_item("2x", Viewport.MSAA_2X)
	option_button.add_item("4x", Viewport.MSAA_4X)
	option_button.add_item("8x", Viewport.MSAA_8X)
	option_button.add_item("16x", Viewport.MSAA_16X)


func _on_ButtonApply_pressed() -> void:
	OS.vsync_enabled = check_box_vertical_synchronization.pressed


func _on_ButtonBack_pressed() -> void:
	scene_tree.change_scene_to(settings_menu)
