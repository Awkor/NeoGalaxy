class_name TitledPanelContainer, "res://assets/icons/titled_panel_container.svg"
extends PanelContainer

export (int) var content_margin = 4
export (String) var title
export (int) var title_margin = 6

var margin_container_bottom := MarginContainer.new()
var margin_container_top := MarginContainer.new()

var title_background := ColorRect.new()
var title_label := Label.new()
var title_margin_container := MarginContainer.new()

var style: StyleBoxFlat = get_stylebox("panel", "PanelContainer")

var v_box_container := VBoxContainer.new()
var v_box_container_separation := 0


func _ready():
	margin_container_bottom.set("custom_constants/margin_bottom", content_margin)
	margin_container_bottom.set("custom_constants/margin_left", content_margin)
	margin_container_bottom.set("custom_constants/margin_right", content_margin)
	margin_container_bottom.set("custom_constants/margin_top", content_margin)
	title_background.color = style.border_color
	title_label.size_flags_horizontal |= SIZE_EXPAND
	title_label.text = title
	title_margin_container.set("custom_constants/margin_bottom", title_margin)
	title_margin_container.set("custom_constants/margin_left", title_margin)
	title_margin_container.set("custom_constants/margin_right", title_margin)
	title_margin_container.set("custom_constants/margin_top", title_margin)
	v_box_container.add_constant_override("separation", v_box_container_separation)

	add_child(v_box_container)
	v_box_container.add_child(margin_container_top)
	v_box_container.add_child(margin_container_bottom)
	margin_container_top.add_child(title_background)
	margin_container_top.add_child(title_margin_container)
	title_margin_container.add_child(title_label)


func _notification(what: int) -> void:
	if what == NOTIFICATION_VISIBILITY_CHANGED:
		_reparent_children()


func _reparent_children() -> void:
	for child in get_children():
		match child:
			margin_container_bottom:
				pass
			margin_container_top:
				pass
			title_background:
				pass
			title_label:
				pass
			title_margin_container:
				pass
			v_box_container:
				pass
			_:
				remove_child(child)
				margin_container_bottom.add_child(child)
