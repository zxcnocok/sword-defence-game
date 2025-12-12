extends Area2D

@export var damage: int = 15
@export var attack_delay: float = 2.0

var attack_timer: Timer
var target = null

func _ready():
	# Инициализируем таймер
	_init_timer()
	
	# Подключаем сигналы
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _init_timer():
	attack_timer = Timer.new()
	attack_timer.wait_time = attack_delay
	attack_timer.one_shot = false  # Повторяющийся
	attack_timer.autostart = false
	attack_timer.timeout.connect(_attack_target)
	add_child(attack_timer)

func _on_body_entered(body):
	if body.is_in_group("enemies"):
		print("👾 Враг вошел в зону: ", body.name)
		if not target:
			target = body
			attack_timer.start()

func _on_body_exited(body):
	if body == target:
		print("👾 Враг вышел из зоны: ", body.name)
		target = null
		attack_timer.stop()

func _attack_target():
	if target and is_instance_valid(target):
		print("🎯 Атакую: ", target.name)
		
		# Проверяем есть ли метод take_damage
		if target.has_method("take_damage"):
			target.take_damage(damage)
		elif "health" in target:
			target.health -= damage
			if target.health <= 0:
				print("💀 Враг умер!")
				target = null
		else:
			print("⚠️ У врага нет свойства health!")
