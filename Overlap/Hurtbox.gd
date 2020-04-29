extends Area2D

const HitEffect = preload("res://Effects/HitEffect.tscn")

var invincible = false setget set_invincible
onready var timer = $Timer

signal invicibility_started
signal invicibility_ended

func set_invincible(value):
	invincible = value
	if invincible == true:
		emit_signal("invicibility_started")
	else:
		emit_signal("invicibility_ended")

func start_invincibility(duration):
	self.invincible = true
	timer.start(duration)

func create_hit_effect():
	var effect = HitEffect.instance()
	effect.global_position = global_position
	var main = get_tree().current_scene
	main.add_child(effect)


func _on_Timer_timeout():
	self.invincible = false


func _on_Hurtbox_invicibility_started():
	set_deferred("monitorable", false)


func _on_Hurtbox_invicibility_ended():
	set_deferred("monitorable", true)
