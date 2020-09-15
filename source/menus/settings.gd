extends Node

onready var back_button := $PanelContainer/ButtonBack
onready var main_menu: PackedScene = load("res://assets/scenes/menus/main.tscn")


func _ready() -> void:
	back_button.connect("button_up", self, "_on_ButtonBack_button_up")


func _on_ButtonBack_button_up() -> void:
	get_tree().change_scene_to(main_menu)
