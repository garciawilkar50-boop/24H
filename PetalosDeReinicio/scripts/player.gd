extends CharacterBody2D

@export var move_speed: float = 260.0
var virtual_direction: Vector2 = Vector2.ZERO
var movement_enabled: bool = true

func _physics_process(_delta: float) -> void:
    if not movement_enabled:
        velocity = Vector2.ZERO
        move_and_slide()
        return

    var direction := Vector2.ZERO
    if Input.is_key_pressed(KEY_A) or Input.is_key_pressed(KEY_LEFT):
        direction.x -= 1.0
    if Input.is_key_pressed(KEY_D) or Input.is_key_pressed(KEY_RIGHT):
        direction.x += 1.0
    if Input.is_key_pressed(KEY_W) or Input.is_key_pressed(KEY_UP):
        direction.y -= 1.0
    if Input.is_key_pressed(KEY_S) or Input.is_key_pressed(KEY_DOWN):
        direction.y += 1.0
    if virtual_direction.length() > 0.1:
        direction = virtual_direction.normalized()

    velocity = direction.normalized() * move_speed
    move_and_slide()
    position.x = clampf(position.x, 70.0, 1850.0)
    position.y = clampf(position.y, 130.0, 900.0)
    queue_redraw()

func _draw() -> void:
    draw_circle(Vector2(0, 26), 19, Color(0, 0, 0, 0.22))
    draw_rect(Rect2(-15, -10, 30, 39), Color("#a78bd4"))
    draw_circle(Vector2(0, -22), 17, Color("#e7c5a4"))
    draw_rect(Rect2(-18, -39, 36, 10), Color("#26283b"))
    draw_rect(Rect2(-14, 8, 10, 20), Color("#3d425e"))
    draw_rect(Rect2(4, 8, 10, 20), Color("#3d425e"))
    draw_circle(Vector2(-6, -23), 2.4, Color("#222333"))
    draw_circle(Vector2(6, -23), 2.4, Color("#222333"))
