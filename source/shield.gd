class_name Shield
extends Node

var capacity: int
var charge: int
var recharge_delay: float
var recharge_delay_timer: Timer
var recharge_rate: int


func _ready() -> void:
	_setup_recharge_delay_timer()


func _process(delta: float) -> void:
	if charge < capacity:
		if recharge_delay_timer.time_left == 0:
			recharge(recharge_rate * delta)


func _setup_recharge_delay_timer() -> void:
	recharge_delay_timer = Timer.new()
	recharge_delay_timer.one_shot = true
	recharge_delay_timer.wait_time = recharge_delay
	add_child(recharge_delay_timer)


func damage(amount: int) -> void:
	charge = max(charge - amount, 0)
	recharge_delay_timer.start()


func recharge(amount: int) -> void:
	charge = min(charge + amount, capacity)
