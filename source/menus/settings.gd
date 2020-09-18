extends Node

onready var button_apply := $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/ButtonApply
onready var button_back := $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/ButtonBack
onready var check_box_borderless := $PanelContainer/MarginContainer/VBoxContainer/CheckBoxBorderless
onready var check_box_fullscreen := $PanelContainer/MarginContainer/VBoxContainer/CheckBoxFullscreen
onready var main_menu := load("res://assets/scenes/menus/main.tscn")


func _ready() -> void:
	check_box_borderless.pressed = OS.window_borderless
	check_box_fullscreen.pressed = OS.window_fullscreen
	button_apply.connect("pressed", self, "_on_ButtonApply_pressed")
	button_back.connect("pressed", self, "_on_ButtonBack_pressed")


func _on_ButtonApply_pressed() -> void:
	OS.window_borderless = check_box_borderless.pressed
	OS.window_fullscreen = check_box_fullscreen.pressed


func _on_ButtonBack_pressed() -> void:
	get_tree().change_scene_to(main_menu)
