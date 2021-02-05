extends Node

export (NodePath) var path_button_apply
export (NodePath) var path_button_back
export (NodePath) var path_check_box_borderless
export (NodePath) var path_check_box_fullscreen
export (NodePath) var path_line_edit_window_height
export (NodePath) var path_line_edit_window_width

onready var button_apply := get_node(path_button_apply)
onready var button_back := get_node(path_button_back)
onready var check_box_borderless := get_node(path_check_box_borderless)
onready var check_box_fullscreen := get_node(path_check_box_fullscreen)
onready var line_edit_window_height := get_node(path_line_edit_window_height)
onready var line_edit_window_width := get_node(path_line_edit_window_width)

onready var settings_menu := load("res://scenes/menus/settings/settings.tscn")
onready var scene_tree := get_tree()


func _ready() -> void:
	button_apply.connect("pressed", self, "_on_ButtonApply_pressed")
	button_back.connect("pressed", self, "_on_ButtonBack_pressed")
	check_box_borderless.pressed = OS.window_borderless
	check_box_fullscreen.pressed = OS.window_fullscreen
	line_edit_window_height.text = str(OS.window_size.y)
	line_edit_window_width.text = str(OS.window_size.x)


func _on_ButtonApply_pressed() -> void:
	OS.window_borderless = check_box_borderless.pressed
	OS.window_fullscreen = check_box_fullscreen.pressed
	OS.window_size.y = int(line_edit_window_height.text)
	OS.window_size.x = int(line_edit_window_width.text)


func _on_ButtonBack_pressed() -> void:
	scene_tree.change_scene_to(settings_menu)
