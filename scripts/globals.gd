extends Node

const GRAVITY = 950

var gained_score: int = 0
var bg_music_playback_position: float = 0.0
var control_simple_mode: bool = false

signal on_obstacle_spawned(obstacle: Node2D)

signal on_obstacle_started_to_move()
signal on_obstacle_stopped_to_move()
