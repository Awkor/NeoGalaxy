extends Node

onready var button_back := $PanelContainer/MarginContainer/VBoxContainer/ButtonBack
onready var check_box_fullscreen := $PanelContainer/MarginContainer/VBoxContainer/CheckBoxBorderless
onready var check_box_borderless := $PanelContainer/MarginContainer/VBoxContainer/CheckBoxFullscreen
onready var main_menu := load("res://assets/scenes/menus/main.tscn")


func _ready() -> void:
	button_back.connect("pressed", self, "_on_ButtonBack_pressed")
	check_box_borderless.connect("toggled", self, "_on_CheckBoxFullscreen_toggled")
	check_box_fullscreen.connect("toggled", self, "_on_CheckBoxBorderless_toggled")


func _on_ButtonBack_pressed() -> void:
	get_tree().change_scene_to(main_menu)


func _on_CheckBoxBorderless_toggled(toggled: bool) -> void:
	OS.window_borderless = toggled


func _on_CheckBoxFullscreen_toggled(toggled: bool) -> void:
	OS.window_fullscreen = toggled
