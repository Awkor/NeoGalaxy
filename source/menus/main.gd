extends Node

export (NodePath) var path_button_quit
export (NodePath) var path_button_settings

onready var button_quit := get_node(path_button_quit)
onready var button_settings := get_node(path_button_settings)

onready var settings_menu: PackedScene = load("res://scenes/menus/settings.tscn")


func _ready() -> void:
	button_quit.connect("pressed", self, "_on_ButtonQuit_pressed")
	button_settings.connect("pressed", self, "_on_ButtonSettings_pressed")


func _on_ButtonQuit_pressed() -> void:
	get_tree().quit()


func _on_ButtonSettings_pressed() -> void:
	get_tree().change_scene_to(settings_menu)
