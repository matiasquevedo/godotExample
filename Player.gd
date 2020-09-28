extends Area2D
signal hit


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var speed = 400
var screen_size


# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	hide()
	pass # Replace with function body.
func _process(delta):
	var velocity = Vector2()  # The player's movement vector.
	var mouse_position = get_viewport().get_mouse_position()
	position = mouse_position
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	if velocity.x != 0:
			$AnimatedSprite.animation = "walk"
			$AnimatedSprite.flip_v = false
			# See the note below about boolean assignment
			$AnimatedSprite.flip_h = velocity.x < 0
	elif velocity.y != 0:
			$AnimatedSprite.animation = "up"
			$AnimatedSprite.flip_v = velocity.y > 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Player_body_entered(body):
	hide()  # Player disappears after being hit.
	emit_signal("hit")
	$CollisionShape2D.set_deferred("disabled", true)
	
func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
