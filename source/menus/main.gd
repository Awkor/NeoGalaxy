extends Node

onready var button_quit := $PanelContainer/VBoxContainer/ButtonQuit
onready var button_settings := $PanelContainer/VBoxContainer/ButtonSettings
onready var settings_menu: PackedScene = load("res://assets/scenes/menus/settings.tscn")


func _ready() -> void:
	button_quit.connect("pressed", self, "_on_ButtonQuit_pressed")
	button_settings.connect("pressed", self, "_on_ButtonSettings_pressed")


func _on_ButtonQuit_pressed() -> void:
	get_tree().quit()


func _on_ButtonSettings_pressed() -> void:
	get_tree().change_scene_to(settings_menu)
