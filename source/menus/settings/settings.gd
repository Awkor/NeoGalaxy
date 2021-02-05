extends Node

export (NodePath) var path_button_back
export (NodePath) var path_button_rendering
export (NodePath) var path_button_window

onready var button_back := get_node(path_button_back)
onready var button_rendering := get_node(path_button_rendering)
onready var button_window := get_node(path_button_window)

onready var main_menu: PackedScene = load("res://scenes/menus/main.tscn")
onready var rendering_settings: PackedScene = preload("res://scenes/menus/settings/rendering.tscn")
onready var window_settings: PackedScene = preload("res://scenes/menus/settings/window.tscn")

onready var scene_tree := get_tree()


func _ready() -> void:
	button_back.connect("pressed", self, "_on_ButtonBack_pressed")
	button_rendering.connect("pressed", self, "_on_ButtonRendering_pressed")
	button_window.connect("pressed", self, "_on_ButtonWindow_pressed")


func _on_ButtonBack_pressed() -> void:
	scene_tree.change_scene_to(main_menu)


func _on_ButtonRendering_pressed() -> void:
	scene_tree.change_scene_to(rendering_settings)


func _on_ButtonWindow_pressed() -> void:
	scene_tree.change_scene_to(window_settings)
