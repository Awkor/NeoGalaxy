extends Node

export (NodePath) var path_button_play
export (NodePath) var path_button_quit
export (NodePath) var path_button_settings

onready var button_play := get_node(path_button_play)
onready var button_quit := get_node(path_button_quit)
onready var button_settings := get_node(path_button_settings)

onready var settings_menu: PackedScene = preload("res://scenes/menus/settings.tscn")
onready var scene: PackedScene = load("res://scenes/tests/chunk_grid.tscn")
onready var scene_tree := get_tree()


func _ready() -> void:
	button_play.connect("pressed", self, "_on_ButtonPlay_pressed")
	button_quit.connect("pressed", self, "_on_ButtonQuit_pressed")
	button_settings.connect("pressed", self, "_on_ButtonSettings_pressed")


func _on_ButtonPlay_pressed() -> void:
	scene_tree.change_scene_to(scene)


func _on_ButtonQuit_pressed() -> void:
	scene_tree.quit()


func _on_ButtonSettings_pressed() -> void:
	scene_tree.change_scene_to(settings_menu)
