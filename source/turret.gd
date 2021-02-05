class_name Turret
extends Node

signal fired(target)
signal reloaded

var optimal_range: int
var falloff_range: int
var rate_of_fire: float
var rate_of_fire_timer: Timer
var ready_to_fire: bool
var reload_time: float
var reload_timer: Timer
var is_reloading: bool setget , is_reloading_get
var tracking_speed: float


func _ready() -> void:
	_setup_rate_of_fire_timer()
	_setup_reload_timer()


func _setup_rate_of_fire_timer() -> void:
	rate_of_fire_timer = Timer.new()
	var error := rate_of_fire_timer.connect("timeout", self, "_on_RateOfFireTimer_timeout")
	assert(error == OK)
	rate_of_fire_timer.wait_time = 1.0 / rate_of_fire
	add_child(rate_of_fire_timer)


func _setup_reload_timer() -> void:
	reload_timer = Timer.new()
	var error := reload_timer.connect("timeout", self, "_on_ReloadTimer_timeout")
	assert(error == OK)
	reload_timer.wait_time = reload_time
	add_child(reload_timer)


func _on_RateOfFireTimer_timeout() -> void:
	ready_to_fire = true


func _on_ReloadTimer_timeout() -> void:
	emit_signal("reloaded")


func fire_at(target: Spatial) -> void:
	ready_to_fire = false
	rate_of_fire_timer.start()
	emit_signal("fired", target)


func is_reloading_get() -> bool:
	return not reload_timer.is_stopped()


func reload() -> void:
	reload_timer.start()
