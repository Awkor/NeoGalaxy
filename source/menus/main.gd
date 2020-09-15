extends Node

onready var button_quit := $PanelContainer/VBoxContainer/ButtonQuit
onready var button_settings := $PanelContainer/VBoxContainer/ButtonSettings
onready var settings_menu: PackedScene = load("res://assets/scenes/menus/settings.tscn")


func _ready() -> void:
	button_quit.connect("button_up", self, "_on_ButtonQuit_button_up")
	button_settings.connect("button_up", self, "_on_ButtonSettings_button_up")


func _on_ButtonQuit_button_up() -> void:
	get_tree().quit()


func _on_ButtonSettings_button_up() -> void:
	get_tree().change_scene_to(settings_menu)
