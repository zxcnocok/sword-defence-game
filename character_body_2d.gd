extends CharacterBody2D

<<<<<<< HEAD
@export var health: int = 100
@export var speed: int = 50
@export var reward: int = 10  # деньги за убийство

func _ready():
	add_to_group("enemies")  # Важно для обнаружения!

func take_damage(damage_amount: int):
	health -= damage_amount
	
	# Эффект получения урона
	$Sprite2D.modulate = Color.RED
	await get_tree().create_timer(0.1).timeout
	$Sprite2D.modulate = Color.WHITE
	
	# Показываем урон над головой
	show_damage_number(damage_amount)
	
	if health <= 0:
		die()

func show_damage_number(damage: int):
	var label = Label.new()
	label.text = "-" + str(damage)
	label.position = Vector2(-20, -30)
	label.add_theme_font_size_override("font_size", 16)
	label.add_theme_color_override("font_color", Color.RED)
	add_child(label)
	
	# Анимация всплывания
	var tween = create_tween()
	tween.tween_property(label, "position:y", -80, 0.8)
	tween.tween_property(label, "modulate:a", 0, 0.2)
	tween.tween_callback(label.queue_free)

func die():
	# Даем деньги игроку
	
	# Удаляем моба
	queue_free()
=======
func _physics_process(delta):
	get_parent().progress += 100 * delta
>>>>>>> a6db057068b143bc9e56c359fec06d6518a46400
