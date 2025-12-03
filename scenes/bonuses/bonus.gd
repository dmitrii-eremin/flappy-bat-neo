extends Node2D

class_name BonusClass

enum Type
{
	EMPTY,
	DOUBLE_SCORE,
	MAKE_WIDER,
}

@export var bonus_type: Type = Type.EMPTY

signal collected(type: Type)

@onready var _sprite = $Sprite2D
@onready var original_position: Vector2 = $Sprite2D.position
@onready var _bonus_sound = $BonusTaken

var _double_score_sprite = load("res://assets/Sprites/Other/DoubleScore.png")
var _make_wider_sprite = load("res://assets/Sprites/Other/MakeWider.png")

var float_anim_time: float = 0.0
var float_speed: float = 0.25
var float_amplitude: float = 16.0

var _is_collected: bool = false

static func get_duration(type: Type) -> int:
	match type:
		Type.DOUBLE_SCORE:
			return 15
		Type.MAKE_WIDER:
			return 15
		Type.EMPTY, _:
			return 0
			
static func get_random_type() -> Type:
	var types: Array[Type] = [
		Type.DOUBLE_SCORE,
		Type.MAKE_WIDER,
	]
	return types.pick_random()
			
func _get_texture(type: Type) -> Texture2D:
	match type:
		Type.DOUBLE_SCORE:
			return _double_score_sprite
		Type.MAKE_WIDER:
			return _make_wider_sprite
		Type.EMPTY, _:
			return null
			
func _ready() -> void:
	set_bonus_type(bonus_type)

func _process(delta: float) -> void:
	float_anim_time += delta
	var offset_y = sin(float_anim_time * TAU * float_speed) * float_amplitude
	_sprite.position.y = original_position.y + offset_y
	
func set_bonus_type(type: Type) -> void:
	bonus_type = type
	_sprite.texture = _get_texture(type)
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		if not _is_collected:
			_is_collected = true
			_bonus_sound.play()
			collected.emit(bonus_type)
			_sprite.hide()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	call_deferred("queue_free")

func _on_bonus_taken_finished() -> void:
	call_deferred("queue_free")
