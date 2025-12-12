extends Node2D

@export var mob_scene: PackedScene
@onready var time = $Timer

var cur_wave = 1  # ← НАЧИНАЕМ С 1, а не с 0!
var mob_to_spawn = 0
var mob_spawned = 0

func _ready() -> void:
	start_wave()

func start_wave():
	print("Волна ", cur_wave, " началась!")
	
	mob_to_spawn = cur_wave * 3  # Волна 1 = 3 моба, волна 2 = 6, и т.д.
	mob_spawned = 0
	
	time.wait_time = 1.0
	time.timeout.connect(_on_timer_timeout)  # ← Подключаем правильную функцию!
	time.start()

func _on_timer_timeout():  # ← Эта функция будет вызываться каждую секунду
	spawn_in_wave()

func spawn_in_wave():
	if mob_spawned < mob_to_spawn:  # ← Проверяем: нужно ли еще спавнить?
		# Создаем моба
		var mob = mob_scene.instantiate()
		mob.position = Vector2(100, 300)
		add_child(mob)
		
		# Увеличиваем счетчик
		mob_spawned += 1
		print("✅ Моб ", mob_spawned, "/", mob_to_spawn, " создан")
		
	else:
		# Все мобы волны созданы
		time.stop()
		time.timeout.disconnect(_on_timer_timeout)  # Отключаем сигнал
		wave_finished()

func wave_finished():
	print("🎉 Волна ", cur_wave, " завершена!")
	
	cur_wave += 1  # Увеличиваем номер волны
	
	# Ждем 10 секунд (ты поставил 10, это много!)
	await get_tree().create_timer(10.0).timeout
	
	# Начинаем новую волну
	start_wave()
