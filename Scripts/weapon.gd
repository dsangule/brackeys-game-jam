extends Area2D

@export var self_hurtbox : HurtboxComponent

var attack_damage = 10.0
var knockback_force = 100.0
var stun_time = 1.5

func _on_area_entered(area):
	if area is HurtboxComponent and area != self_hurtbox:
		var hurtbox = area
		var attack = attack_damage
		
		hurtbox.damage(attack)
