extends Node

onready var back_button := $PanelContainer/ButtonBack
onready var main_menu: PackedScene = load("res://assets/scenes/menus/main.tscn")


func _ready() -> void:
	back_button.connect("pressed", self, "_on_ButtonBack_pressed")


func _on_ButtonBack_pressed() -> void:
	get_tree().change_scene_to(main_menu)
