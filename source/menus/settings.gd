extends Node

export (NodePath) var path_button_apply
export (NodePath) var path_button_back
export (NodePath) var path_check_box_borderless
export (NodePath) var path_check_box_fullscreen
export (NodePath) var path_check_box_vertical_synchronization

onready var button_apply := get_node(path_button_apply)
onready var button_back := get_node(path_button_back)
onready var check_box_borderless := get_node(path_check_box_borderless)
onready var check_box_fullscreen := get_node(path_check_box_fullscreen)
onready var check_box_vertical_synchronization := get_node(path_check_box_vertical_synchronization)

onready var main_menu := load("res://scenes/menus/main.tscn")


func _ready() -> void:
	check_box_borderless.pressed = OS.window_borderless
	check_box_fullscreen.pressed = OS.window_fullscreen
	check_box_vertical_synchronization.pressed = OS.vsync_enabled
	button_apply.connect("pressed", self, "_on_ButtonApply_pressed")
	button_back.connect("pressed", self, "_on_ButtonBack_pressed")


func _on_ButtonApply_pressed() -> void:
	OS.window_borderless = check_box_borderless.pressed
	OS.window_fullscreen = check_box_fullscreen.pressed
	OS.vsync_enabled = check_box_vertical_synchronization.pressed


func _on_ButtonBack_pressed() -> void:
	get_tree().change_scene_to(main_menu)
